<%-- 
    Document   : menuListPage
    Created on : Jan 27, 2021, 5:12:43 PM
    Author     : ainal farhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Menu</title>
        <style><%@include file="../../../../css/style/global.css"%></style>
        <style><%@include file="../../../../css/style/manageMenu.css"%></style>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        
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
    </head>
    <body>
        <header>
            <%@include file = "../../components/navigationBar.jsp" %>
        </header>
        
        <div class="content-container">
            <div class="container manage-menu-container bgContent bg-light p-4">
                <div class="register-form">
                    <div class="card-header bg-dark text-white">
                        <h3 style="text-align: center">Add New Food</h3>
                    </div>
                    <form action="ManageFoodServlet" method="POST" class="mt-3" onSubmit="return checkEitherImageIsSelected()">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="foodName">Food name:</label>
                                    <input type="text" class="form-control form-control-lg" placeholder="Enter food name" name="foodName" id="foodName" required>
                                </div>

                                <div class="form-group">
                                    <label for="foodPrice">Food price:</label>
                                    <div class="input-group mb-3 input-group-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><b>RM</b></span>
                                        </div>
                                        <input type="number" class="form-control" placeholder="" name="foodPrice" id="foodPrice" min="0" value="<%= String.format("%.2f", 1.0) %>" step="0.01" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="foodDescription">Food description:</label>
                                    <input type="text" class="form-control form-control-lg" placeholder="Enter food description" name="foodDescription" id="foodDescription" required>
                                </div>
                                <div class="form-group">
                                    <label for="foodCategory">Food category:</label>
                                    <select class="form-control form-control-lg" placeholder="Enter food category" name="foodCategory" id="foodCategory" required>
                                        <option value="">Select category</option>
                                        <option value="breakfast">Breakfast</option>
                                        <option value="lunch">Lunch</option>
                                        <option value="dinner">Dinner</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col">
                                Upload image:
                                <div class="form-group" style="display:block;margin-right:auto;margin-left:auto;width: 90%;">
                                    <img id="profilePicture" src="" alt="profile picture" class="mx-auto d-block custom-shadow mb-3" width="200" height="200" style="border-radius: 50%;">
                                    <div id="update-pic-form mt-2">
                                        <span id="fileSelected">Selected Image: None</span>

                                        <input type="file" name="selectedImage" class="form-control-file" accept="image/*" id="fileName" accept=".jpg,.jpeg,.png" onchange="validateFileType(event)" style="display:none;">
                                        <label for="fileName" class="btn btn-primary">Browse</label>

                                        <input type="hidden" id="uploadedFileName" name="uploadedFileName" value="" required>
                                        <input type="hidden" id="fileContent" name="uploadedBase64Image" value="" required>

                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="mt-5">
                                <input type="hidden" name="action" value="addNewFood">
                                <input type="submit" class="btn btn-success btn-block btn-lg" value="Confirm"/>
                            </div>
                    </form>
                    
                    <div class="mt-2">
                        <form action="ManageFoodServlet" method="POST">
                            <input type="hidden" name="action" value="viewListOfMenu">
                            <input type="submit" class="btn btn-danger btn-block btn-lg" value="Cancel"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <%@include file = "../../components/footer.jsp" %>
        </footer>
    </body>
</html>
