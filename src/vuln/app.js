const express = require('express');
const bodyParser = require('body-parser');
const _ = require('lodash');
const app = express();


//const validate = require('express-validation');
process.env.PWD = process.cwd()

// Then
app.use(express.static(process.env.PWD + '/public'));
app.use(bodyParser.json()); // Parse JSON bodies

// Initialize user details object
let userDetails = {
    firstname: 'ahmed',
    lastname: 'mohamed',
    age: 20
};

// Serve the HTML form
app.get('/update', (req, res) => {
    res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <a href="/">Home</a>  &nbsp;&nbsp;&nbsp;&nbsp;  <a href="/update">profile</a>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Details Form</title>
    </head>
    <body>
        <h1>User Profile</h1>
        <form id="userForm">
            <label for="firstname">First Name:</label><br>
            <input type="text" id="firstname" name="firstname"><br>
            <label for="lastname">Last Name:</label><br>
            <input type="text" id="lastname" name="lastname"><br>
            <label for="age">Age:</label><br>
            <input type="number" id="age" name="age"><br><br>
            <button type="submit">Submit</button>
        </form>
        <p id="modify">Modify your details</p>

        <script>
            const form = document.getElementById('userForm');
    
            form.addEventListener('submit', async function(event) {
                event.preventDefault(); // Prevent default form submission
    
                // Create FormData object from the form
                const formData = new FormData(form);
    
                // Convert FormData to JSON object
                const jsonObject = {};
                formData.forEach((value, key) => {
                    jsonObject[key] = value;
                });
    
                // Send JSON data using Fetch API
                try {
                    const response = await fetch('/update', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(jsonObject)

                    });
    
                    if (response.ok) {
                        const responseData = await response.json();
                        console.log(responseData);
                        document.getElementById("modify").innerHTML = "user updated successfully";
                        //document.write("user updated successfully");
                    } else {
                        console.error('Failed to update user details');
                    }
                } catch (error) {
                    console.error('Error:', error);
                }
            });
        </script>
     
    </body>
    </html>
    
    `);
});

app.post('/update', (req, res) => {
    const userData = req.body; 
    //console.log(userData);
    userDetails = _.merge(userDetails, userData); //Vulnerability Here
    
    const data = {
        firstname: userDetails.firstname,
        lastname: userDetails.lastname,
        age: userDetails.age
    };

    res.json({ message: 'User details updated successfully', data });
    
});

app.get('/details', (req, res) => {
    const data = {
        firstname: userDetails.firstname,
        lastname: userDetails.lastname,
        age: userDetails.age
    };
    res.json(data);
});

app.get('/', (req, res) => {
res.send(
    `<html>

<a href="/">Home</a>  &nbsp;&nbsp;&nbsp;&nbsp;  <a href="/update">profile</a>


    <h1>User Profile</h1>
    <b>Hello ${userDetails.firstname} ${userDetails.lastname} <br>
    </b>


<br><br>

<img src="/proto.png"></img>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="/jquery-plugin.js"></script>
    <script>
    async function logQuery(url, params) {
        try {
            await fetch(url, {method: "post", keepalive: true, body: JSON.stringify(params)});
        } catch(e) {
            console.error("Failed storing query");
        }
    }
    
    async function searchLogger() {
        let config = {};
    
        if(config.transport_url) {
            let script = document.createElement('script');
            script.src = config.transport_url;
            document.body.appendChild(script);
        }
    
        if(config.params && config.params.search) {
            await logQuery('/logger', config.params);
        }
    }
    
    window.addEventListener("load", searchLogger);
 </script>
<script src="/search.js"></script>
<script src="/sink.js"></script>

    </html>
    `
)

});

function logMessage() {
    let newObj = {};
    console.log('newObj.admin', newObj.admin);

}


app.get('/fork', (req, res) => {
    const { fork } = require('child_process');

    const childProcess = fork('child.js');
    res.send("fork happened, check Burp Collab")
});


app.get('/admin', (req, res) => {
    let access={};
if(access.admin===true){
    res.send("flag{PP}")
}
else
{
res.send("no flag")
}
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
    setInterval(logMessage, 3000);
});

