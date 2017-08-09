
addLoadEvent(prepareAddFunction);
addLoadEvent(prepareSendPost);

function prepareAddFunction() {
    var addButton = document.getElementById("addButton");
    addButton.onclick = function() {
        var div = document.getElementById("customDiv");
        var newDiv = div.cloneNode(true)
        document.getElementById("userDiv").appendChild(newDiv);
    }
}

function prepareSendPost() {
    var postButton = document.getElementById("postButton");
    var toPostForm = postButton.form;
    postButton.onclick = function() {
        var variableNames = document.getElementsByClassName("inputVariableName");
        var variableTypes = document.getElementsByClassName("selectVariableType");
        var data = {};
        for (var i=0; i < variableNames.length; i++) {
            data[variableNames[i].value] = variableTypes[i].value;
        }
        
        var xhr = new XMLHttpRequest();
        xhr.open(toPostForm.method, toPostForm.action, true)
        xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
        xhr.send(JSON.stringify(data));
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status==200){
                var textarea = document.getElementById("resultArea");
                textarea.value = xhr.responseText
            }
        }
    }
}

function addLoadEvent(func) {
    var oldonload = window.onload;
    if (typeof window.onload != 'function') {
        window.onload = func;
    } else {
        window.onload = function() {
            oldonload();
            func();
        }
    }
}
