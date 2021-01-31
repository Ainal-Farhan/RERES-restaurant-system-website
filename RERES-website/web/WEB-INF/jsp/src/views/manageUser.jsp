<%@page import="com.RERES.references.SessionReference"%>
<%@page import="com.RERES.utility.ImageUtility"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage User Page</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/manageUser.css"%></style>
    </head>
    <body>        
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
            <jsp:useBean id="selectedUser" scope="request" class="com.RERES.model.User" />
        
        <div class="content-container">
            <div class="container manage-user-container">
                <div class="form-group">
                    <h1 style="text-align: center">User Details</h1>
                </div>
                <%  
                    String userType = (String)request.getAttribute("selectedUserType");
                %>

                <div class="form-group" style="display:block;margin-right:auto;margin-left:auto;width: 90%;">
                    <img id="profilePicture" src="UserServlet?action=getSelectedUserProfilePicture" alt="profile picture" class="mx-auto d-block custom-shadow" width="200" height="200" style="border-radius: 50%;">
                    
                    <form action="UserServlet" method="POST" onSubmit="return checkEitherImageIsSelected()">
                        <div id="update-pic-form">
                            <span id="fileSelected"> Selected Image: None</span>

                            <input type="file" name="selectedImage" class="form-control-file" accept="image/*" id="fileName" accept=".jpg,.jpeg,.png" onchange="validateFileType(event)" style="display:none;">
                            <label for="fileName" class="btn btn-primary">Browse</label>

                            <input type="hidden" id="uploadedFileName" name="uploadedFileName" value="" required>
                            <input type="hidden" name="action" value="updateUserProfilePicture">
                            <input type="hidden" id="fileContent" name="uploadedBase64Image" value="" required>

                            <input type="submit" class="btn btn-primary" id="uploadButton" value="Upload" name="upload-btn" style="margin-bottom: 8px;">

                            <%  if(!(selectedUser.getProfilePhoto()).equals(ImageUtility.USER_DEFAULT_PROFILE_PICTURE)) { %>
                            <input type="submit" class="btn btn-primary" value="Default" name="default-btn" style="margin-bottom: 8px;" onClick="toDefault()">
                            <%  } %>
                        </div>
                    </form>

                    <script type="text/javascript">                    
                        var statusUpload = false;

                        function validateFileType(event){
                            var fileName = document.getElementById("fileName").value;

                            fileName = fileName.replace(/.*[\/\\]/, '');

                            var idxDot = fileName.lastIndexOf(".") + 1;

                            var extFile = fileName.substr(idxDot, fileName.length).toLowerCase();

                            if (extFile==="jpg" || extFile==="jpeg" || extFile==="png"){
                                document.getElementById('fileSelected').innerHTML = " Selected Image: " + fileName;
                                document.getElementById('uploadedFileName').value = fileName;

                                // If file size > 500kB, resize such that width <= 1000, quality = 0.9
                                reduceFileSize(event.target.files[0], 500*1024, 1000, Infinity, 0.9, blob => {
                                    let body = new FormData();
                                    body.set('file', blob, blob.name || "file.jpg");
                                    getBase64(body.get('file'))
                                        .then(data => { 
                                                var base64result = data.split(',')[1];
                                                document.getElementById("fileContent").value = base64result;
                                                var output = document.getElementById('profilePicture');
                                                output.src = data;
                                                statusUpload = true;
                                            }
                                        ).catch(err => {
                                            statusUpload = false;
                                            console.log(err);
                                        });
                                });
                            }else{
                                document.getElementById('fileSelected').innerHTML = " Selected Image: None";
                                alert("Only jpg/jpeg and png files are allowed!");
                            }   
                        }

                        function getBase64(file) {
                            return new Promise((resolve, reject) => {
                                const reader = new FileReader();
                                reader.readAsDataURL(file);
                                reader.onload = () => resolve(reader.result);
                                reader.onerror = error => reject(error);
                            });
                        }                        

                        function toDefault() {
                            statusUpload = true;
                        }

                        function checkEitherImageIsSelected() {
                            if(statusUpload === null || statusUpload === undefined || statusUpload === false) {
                                if(document.getElementById("fileContent").value === "" || document.getElementById('fileContent').value === undefined || document.getElementById('fileContent').value === null) {
                                    alert("You have not selected any image to be uploaded");
                                }
                                return false;
                            }

                            return statusUpload;
                        }

                        // From https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/toBlob, needed for Safari:
                        if (!HTMLCanvasElement.prototype.toBlob) {
                            Object.defineProperty(HTMLCanvasElement.prototype, 'toBlob', {
                                value: function(callback, type, quality) {

                                    var binStr = atob(this.toDataURL(type, quality).split(',')[1]),
                                        len = binStr.length,
                                        arr = new Uint8Array(len);

                                    for (var i = 0; i < len; i++) {
                                        arr[i] = binStr.charCodeAt(i);
                                    }

                                    callback(new Blob([arr], {type: type || 'image/png'}));
                                }
                            });
                        }

                        window.URL = window.URL || window.webkitURL;

                        // Modified from https://stackoverflow.com/a/32490603, cc by-sa 3.0
                        // -2 = not jpeg, -1 = no data, 1..8 = orientations
                        function getExifOrientation(file, callback) {
                            // Suggestion from http://code.flickr.net/2012/06/01/parsing-exif-client-side-using-javascript-2/:
                            if (file.slice) {
                                file = file.slice(0, 131072);
                            } else if (file.webkitSlice) {
                                file = file.webkitSlice(0, 131072);
                            }

                            var reader = new FileReader();
                            reader.onload = function(e) {
                                var view = new DataView(e.target.result);
                                if (view.getUint16(0, false) != 0xFFD8) {
                                    callback(-2);
                                    return;
                                }
                                var length = view.byteLength, offset = 2;
                                while (offset < length) {
                                    var marker = view.getUint16(offset, false);
                                    offset += 2;
                                    if (marker == 0xFFE1) {
                                        if (view.getUint32(offset += 2, false) != 0x45786966) {
                                            callback(-1);
                                            return;
                                        }
                                        var little = view.getUint16(offset += 6, false) == 0x4949;
                                        offset += view.getUint32(offset + 4, little);
                                        var tags = view.getUint16(offset, little);
                                        offset += 2;
                                        for (var i = 0; i < tags; i++)
                                            if (view.getUint16(offset + (i * 12), little) == 0x0112) {
                                                callback(view.getUint16(offset + (i * 12) + 8, little));
                                                return;
                                            }
                                    }
                                    else if ((marker & 0xFF00) != 0xFF00) break;
                                    else offset += view.getUint16(offset, false);
                                }
                                callback(-1);
                            };
                            reader.readAsArrayBuffer(file);
                        }

                        // Derived from https://stackoverflow.com/a/40867559, cc by-sa
                        function imgToCanvasWithOrientation(img, rawWidth, rawHeight, orientation) {
                            var canvas = document.createElement('canvas');
                            if (orientation > 4) {
                                canvas.width = rawHeight;
                                canvas.height = rawWidth;
                            } else {
                                canvas.width = rawWidth;
                                canvas.height = rawHeight;
                            }

                            if (orientation > 1) {
                                console.log("EXIF orientation = " + orientation + ", rotating picture");
                            }

                            var ctx = canvas.getContext('2d');
                            switch (orientation) {
                                case 2: ctx.transform(-1, 0, 0, 1, rawWidth, 0); break;
                                case 3: ctx.transform(-1, 0, 0, -1, rawWidth, rawHeight); break;
                                case 4: ctx.transform(1, 0, 0, -1, 0, rawHeight); break;
                                case 5: ctx.transform(0, 1, 1, 0, 0, 0); break;
                                case 6: ctx.transform(0, 1, -1, 0, rawHeight, 0); break;
                                case 7: ctx.transform(0, -1, -1, 0, rawHeight, rawWidth); break;
                                case 8: ctx.transform(0, -1, 1, 0, 0, rawWidth); break;
                            }
                            ctx.drawImage(img, 0, 0, rawWidth, rawHeight);
                            return canvas;
                        }

                        function reduceFileSize(file, acceptFileSize, maxWidth, maxHeight, quality, callback) {
                            if (file.size <= acceptFileSize) {
                                callback(file);
                                return;
                            }
                            var img = new Image();
                            img.onerror = function() {
                                URL.revokeObjectURL(this.src);
                                callback(file);
                            };
                            img.onload = function() {
                                URL.revokeObjectURL(this.src);
                                getExifOrientation(file, function(orientation) {
                                    var w = img.width, h = img.height;
                                    var scale = (orientation > 4 ?
                                        Math.min(maxHeight / w, maxWidth / h, 1) :
                                        Math.min(maxWidth / w, maxHeight / h, 1));
                                    h = Math.round(h * scale);
                                    w = Math.round(w * scale);

                                    var canvas = imgToCanvasWithOrientation(img, w, h, orientation);
                                    canvas.toBlob(function(blob) {
                                        console.log("Resized image to " + w + "x" + h + ", " + (blob.size >> 10) + "kB");
                                        callback(blob);
                                    }, 'image/jpeg', quality);
                                });
                            };
                            img.src = URL.createObjectURL(file);
                        }
                    </script>
                </div>
                    
                <form action="UserServlet" method="POST" onsubmit="return performSubmit()">
                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="name">Name</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="name" id="Name" value="<jsp:getProperty name="selectedUser" property="name"/>" required>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserID">User ID</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="userID"/></label>
                        </div>
                        <div class="col-2">
                            <label for="UserName">Username</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="username"/></label>
                        </div>
                    </div>
                        <%
                            int currentAge = Period.between(LocalDate.parse(selectedUser.getBirthDate().toString()), LocalDate.now()).getYears();
                        %>
                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserAge">Age</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><%= currentAge %></label>
                            <input type="hidden" class="form-control" name="user-age" value="<%= currentAge %>">
                        </div>

                        <div class="col-2">
                            <label for="UserBirthDate">Birth Date</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="birthDate"/></label>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserType">Type</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="userType"/></label>
                        </div>

                        <div class="col-2">
                            <label for="UserGender">Gender</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text"><jsp:getProperty name="selectedUser" property="gender"/></label>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserEmail">Email</label>
                        </div>
                        <div class="col">
                            <input type="email" class="form-control" name="user-email" id="UserEmail" value="<jsp:getProperty name="selectedUser" property="email"/>" required>
                        </div>

                        <div class="col-2">
                            <label for="UserPhoneNo">Phone No</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="user-phone-no" id="UserPhoneNo" value="<jsp:getProperty name="selectedUser" property="phoneNumber"/>" required>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="UserAddress">Address</label>
                        </div>
                        <div class="col">
                            <textarea class="form-control" name="user-address" id="UserAddress" cols="30" rows="6" required style="resize:none;"><jsp:getProperty name="selectedUser" property="address"/></textarea>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <% if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                        <input type="hidden" name="action" value="updateOrDeleteUser" required>
                        <button type="button" class="btn btn-success btn-group-manage-user" onclick="changeInputStatus(false)" id="update-btn">Update</button>
                        <input type="submit" class="btn btn-success btn-group-manage-user" id="save-btn" name="save-button" value="Save" onclick="updateConfirmation()">
                        <button type="button" class="btn btn-primary btn-group-manage-user" id="back-btn" onclick="changeInputStatus(true)">Back</button>
                        <% } %>
                        
                        <% if(currentUserType.equalsIgnoreCase("admin") && (Integer)session.getAttribute(SessionReference.CURRENT_USER_ID) != selectedUser.getUserID()) { %>
                        <input type="submit" class="btn btn-danger btn-group-manage-user" id="delete-btn" name="delete-button" value="Delete" onclick="deleteConfirmation()">
                        <% } %>
                        
                        
                    </div>
                </form>
            </div>
        </div>
                        
        <script>
            changeInputStatus(true);
            
            function changeInputStatus(status) {
                var styleDisplay = "none";
                if(status === true) styleDisplay = "none";
                else styleDisplay = "block";
                
                document.getElementById("Name").readOnly = status;
                document.getElementById("UserEmail").readOnly = status;
                document.getElementById("UserPhoneNo").readOnly = status;
                document.getElementById("UserAddress").readOnly = status;
                document.getElementById("update-pic-form").style.display = styleDisplay;
                if(status !== true) {                    
                    <% if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                    document.getElementById("update-btn").style.display="none";
                    document.getElementById("back-btn").style.display="block";
                    document.getElementById("save-btn").style.display="block";
                    <% } %>
                    <% if(currentUserType.equalsIgnoreCase("admin")) { %>
                    document.getElementById("delete-btn").style.display="none";
                    <% } %>
                    
                } else {
                    <% if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                    document.getElementById("update-btn").style.display="block";
                    document.getElementById("back-btn").style.display="none";
                    document.getElementById("save-btn").style.display="none";
                    <% } %>
                    <% if(currentUserType.equalsIgnoreCase("admin")) { %>
                    document.getElementById("delete-btn").style.display="block";
                    <% } %>
                    
                }
            }
            
            var statusSubmit = false;
            
            <%  if(currentUserType.equalsIgnoreCase("admin")) { %>
                function deleteConfirmation() {
                    statusSubmit = confirm("Delete user? please be advised as this action in irreversible");
                }
                <% } %>
            <%  if((currentUserType.equalsIgnoreCase("staff") && userType.equals("staff")) || (currentUserType.equalsIgnoreCase("customer")) || (currentUserType.equalsIgnoreCase("admin"))) { %>
                    function updateConfirmation() {
                        statusSubmit = confirm("Update Information?");
                    }
            <%  } %>
            
            function performSubmit() {
                return statusSubmit;
            }
        </script>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
