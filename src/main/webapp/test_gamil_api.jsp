<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.11.1/css/all.css">
<link
	href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
	rel="stylesheet">
	  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	   <script src="https://cdnjs.cloudflare.com/ajax/libs/Base64/1.1.0/base64.js" ></script>
  </head>
  
 <style>
 html, body {
	height: 100%;
}
 .big_button {
	padding-left: 35px !important;
	padding-right: 35px !important;
	color: white !important;
	height: 40px !important;
	background-color: #ed4d67 !important;
}
.big_button:hover {
	background-color: #bf263f !important;
}

.big_button:active {
	background-color: #f7657d !important;
}
 </style>
<body>



	<main role="main" class="h-100">
	<div class="container h-100">

		<div class="row m-0 align-items-center d-flex justify-content-center h-100">
			<div class="col ">
				<!--Add buttons to initiate auth sequence and sign out-->
<div class="h5 pb-2"> Gmail API</div>
				<button id="authorize_button" type="button"
					class=" btn  big_button rounded-0 font-weight-bold mb-5 "
					style="display: none;">Sign In</button>
					<div class=" row signouthide">
					<div class="col">
					<button id="see_mails" type="button"
					class=" btn  big_button rounded-0 font-weight-bold mb-2"
					style="display: none;">See mails</button>
					<div id="content" style="white-space: pre-wrap;"></div>
				<ul class="list-group" id="mail" style="display: none;">

				</ul>
					</div>
					<div class="col">
				
					<div class="card data_card" style="width: 500px;display:none">
					<div class="card-header">
    Send mail
  </div>
					<div class="card-body">
						<form action="">
							<div class="form-group">
								<label for="exampleFormControlInput1">Email address</label> <input
									type="email" class="form-control" id="emailadd"
									placeholder="To">
							</div>
							<div class="form-group">
								<label for="exampleFormControlTextarea1">Message</label>
								<textarea class="form-control" id="write_message"
									rows="3" placeholder="write here"></textarea>
							</div>
							
				<button id="send_msg" type="button"
					class=" btn  big_button rounded-0 font-weight-bold "
					onclick="sentMessage()">Send</button>
						</form>
					</div>
				</div>
				</div>
					</div>
             
	
				
			<button id="signout_button" type="button"
					class=" btn  big_button rounded-0 font-weight-bold  "
					style="display: none;">Sign Out</button>
				
			</div>

		</div>
	</div>
	</main>

	<script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
    
    
    <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '492177962308-k2o41d3pq28o60i3anjfuh4cfg2hbbne.apps.googleusercontent.com';
      var API_KEY = 'AIzaSyDUI8cEkEtHgW8QV2MW551e_k3SocX-EOw';

      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/gmail/v1/rest"];
  	  var SCOPES ='https://mail.google.com/';
      var authorizeButton = document.getElementById('authorize_button');
      var signoutButton = document.getElementById('signout_button');

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        }, function(error) {
          appendPre(JSON.stringify(error, null, 2));
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
          authorizeButton.style.display = 'none';
          signoutButton.style.display = 'block';
          
          //userMessage()
         displayInbox();
         // createDraft();
        } else {
          authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none';
        }
      }

      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
      }

      /**
       * Print all Labels in the authorized user's inbox. If no labels
       * are found an appropriate message is printed.
       */
      
     
       
    	  function userMessage() {
       	  gapi.client.gmail.users.messages.get({
             'userId': 'abhishekprajapati@salesken.ai',
             'id':'16f1804c57f52b40',
     	    'maxResults': 5
           }).then(function(response) {
        	  
            	console.log(response); 
            	
            	$('#content').append("");
           });
         } 
      
    	  function listLabels(userId) {
    		  var request = gapi.client.gmail.users.labels.list({
    		    'userId': userId
    		  });
    		  request.execute(function(resp) {
    		    var labels = resp.labels;
    		   console.log(resp);
    		   
    		  });
    		}
    	  
    	  function displayInbox() {
    		  var request = gapi.client.gmail.users.messages.list({
    	      'userId': 'abhishekprajapati@salesken.ai',
    		    'labelIds': 'INBOX',
    		    'maxResults': 10
    		  });

    		  request.execute(function(response) {
    		    $.each(response.messages, function() {
    		      var messageRequest = gapi.client.gmail.users.messages.get({
    	    	    'userId': 'abhishekprajapati@salesken.ai',
    		        'id': this.id
    		      });

    		      messageRequest.execute(appendMessageRow);
    		    });
    		  });
    		}
    	  function appendMessageRow(message) {
    		console.log(message)  
    	  	var new_li = '  <li class="list-group-item disabled" aria-disabled="true">'+message.snippet+'</li>';
    	  	$('#mail').append(new_li);
    	  }
    	 
    	  function sentMessage(){
    		  var mailid=$('#emailadd').val();
    	    	 var message= $('#write_message').val();
    	    	 var headers_obj={To:mailid};
    	    	 sendMessage(headers_obj, message);
    	  }
    	
    	  function sendMessage(headers_obj, message)
    	  {
    	    var email = '';
    	 
    	  for(var header in headers_obj)
    	      email += header += ": "+headers_obj[header]+"\r\n";

    	    email += "\r\n" + message;
			
    	    var sendRequest = gapi.client.gmail.users.messages.send({
      	      'userId': 'abhishekprajapati@salesken.ai',
    	      'resource': {
    	        'raw': window.btoa(email).replace(/\+/g, '-')
    	      }
    	    });
    	  
    	    sendRequest.execute(function(resp) {
    		   console.log(resp);
    		   
    		  }); 
    	    alert("Message Sent");
    	  }
 
  $('#authorize_button').click(function(){
	  $('.data_card').show();
	  $('#signout_button').show();
	  $('#see_mails').show();
	  $('.signouthide').show();
	});
  $('#see_mails').click(function(){
	  $('#mail').show();
	});
  
  $('#signout_button').click(function(){
	  $('.signouthide').hide();
	});
    </script>

   
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
 
  </body>
</html>