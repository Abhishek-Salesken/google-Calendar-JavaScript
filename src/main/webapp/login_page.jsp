<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
	String url = request.getRequestURL().toString();
	String baseURL = url.substring(0, url.length() - request.getRequestURI().length())
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.11.1/css/all.css">
<link
	href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
	rel="stylesheet">
	  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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

</head>

<body>
<main role="main" class="h-100">
    <div class="container h-100">
    
    <div class="row m-0 align-items-center d-flex justify-content-center h-100">
   
    <div class="col text-center">
     <div class=" text-center h4 pb-5">Google Calendar API Quickstart</div>
    	<button id="authorize_button" type="button" class=" btn  big_button rounded-0 font-weight-bold ">Sign In	</button>
    </div>
    
    </div>
</div>
</main>

<script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
</script>

<script>
// Client ID and API key from the Developer Console
var CLIENT_ID = '492177962308-k2o41d3pq28o60i3anjfuh4cfg2hbbne.apps.googleusercontent.com';
var API_KEY = 'AIzaSyDUI8cEkEtHgW8QV2MW551e_k3SocX-EOw';

// Array of API discovery doc URLs for APIs used by the quickstart
/* var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"]; */

// Authorization scopes required by the API; multiple scopes can be
// included, separated by spaces.
// var SCOPES ="https://www.googleapis.com/auth/calendar"; */
var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/gmail/v1/rest"];
var SCOPES ='https://mail.google.com/';

var authorizeButton = document.getElementById('authorize_button');


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
    authorizeButton.onclick = handleAuthClick;
  }, function(error) {
    appendPre(JSON.stringify(error, null, 2));
  });
}

/**
 *  Sign in the user upon button click.
 */
function handleAuthClick(event) {
  gapi.auth2.getAuthInstance().signIn();
  
}
/**
 *  Called when the signed in status changes, to update the UI
 *  appropriately. After a sign-in, the API is called.
 */
function updateSigninStatus(isSignedIn) {
  if (isSignedIn) {
    openSecondPage();
  } else {
    
   
  }
}

function openSecondPage(){
	  location.href=location.protocol+"//"+location.host+"/google-Calendar-JavaScript/test_calendar.jsp"
}

</script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
</body>
</html>