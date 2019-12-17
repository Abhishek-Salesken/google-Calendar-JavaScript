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
  </head>
  
 <style>
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
    <!--Add buttons to initiate auth sequence and sign out-->
    <div class="m-4 ">
	<div class="card mb-4 ">
		<div class="card-header text-center h4">Google Calendar API Quickstart</div>
		<div class="card-body">
	 	<button type="button" class="btn big_button rounded-0  mb-4 font-weight-bold"   id="view_button">View Events</button>
	 	<button type="button" class="btn big_button rounded-0  mb-4  font-weight-bold float-right"  id="creat_btn"   data-toggle="modal" data-target="#createModal">Create New Event</button>
		<ul class="list-group" id="event_container" style="display: none;">

		</ul>
			</div>
	</div>
	

	<div class="d-flex">
	<button id="signout_button" type="button" class=" btn  big_button rounded-0 font-weight-bold ">Sign Out</button>
	</div>
	

<!-- Modal For update event -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog  modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Update Events</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" data-event=" ">
        <form>
  <div class="form-group">
  <!--   <label for="exampleFormControlSelect1">event Id</label> -->
   <input type="hidden" class="form-control" id="eventId" placeholder="type here">
  </div>
  <div class="form-group">
  <label for="exampleFormControlSelect1">Summary</label>
   <input type="text" class="form-control" id="summary" placeholder="type here">
  </div>
 <div class="form-group">
  <label for="exampleFormControlSelect1">Start date Time</label>
   <input type="datetime-local" class="form-control" id="startdate" placeholder="type here">
  </div>
  <div class="form-group">
 <label for="exampleFormControlSelect1">End date Time</label>
   <input type="datetime-local" class="form-control" id="enddate" placeholder="type here">
  </div>
  <div class="form-group">
    <label for="exampleFormControlTextarea1">Update description</label>
    <textarea class="form-control" id="description" rows="3"></textarea>
  </div>
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick=storevalue() data-dismiss="modal">Save changes</button>
       
      </div>
    </div>
  </div>
</div>
	<!--end Modal For update event -->
	
<!--Start Modal For create event -->
<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog  modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Create Events</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" data-createevent=" " id="create_event_body">
        <form>
  <div class="form-group">
  <!--   <label for="exampleFormControlSelect1">event Id</label> -->
   <input type="hidden" class="form-control" id="eventId" placeholder="type here">
  </div>
  <div class="form-group">
  <label for="exampleFormControlSelect1">Summary</label>
   <input type="text" class="form-control" id="create_summary" placeholder="type here">
  </div>
 <div class="form-group">
  <label for="exampleFormControlSelect1">Start date Time</label>
  
   <input type="datetime-local" class="form-control" id="create_start_date" placeholder="type here" value="">
  </div>
  <div class="form-group">
 <label for="exampleFormControlSelect1">End date Time</label>
   <input type="datetime-local" class="form-control" id="create_end_date" placeholder="type here">
  </div>
  <div class="form-group">
    <label for="exampleFormControlTextarea1">Update description</label>
    <textarea class="form-control" id="create_description" rows="3"></textarea>
  </div>
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="createevent()">Create Event</button>
      </div>
    </div>
  </div>
</div>
	<!--end Modal For Create event -->
 </div>
  <script>
  
  /* Start of Update event function */
  function storevalue(){
	 var event=JSON.parse($('.modal-body').attr('data-event'));
	 var new_start_date= new Date($('#startdate').val());
	 var new_end_date= new Date($('#enddate').val());
	 var desc =$('#description').val();
	 var summary =$('#summary').val();
	 event.start={dateTime:ISODateString(new_start_date)};
	 event.end={dateTime:ISODateString(new_end_date)};
	 event.description=desc;
	 event.summary=summary;
	 console.log(event);
	 var request = gapi.client.calendar.events.update({
		  'calendarId': 'primary',
		  'eventId':event.id,
		  'resource': event
		});

		request.execute(function(event) {
		  appendPre('Event created: ' + event.htmlLink);
		});
  }
  
  /* Start of create new event function */
  function createevent(){
		 //var event=$("#create_event_body").attr("data-createevent");
		 var event={};
		 console.log(event);
		  var start_date= new Date($('#create_start_date').val());
		 var end_date= new Date($('#create_end_date').val());
		 var descr =$('#create_description').val();
		 var summary1 =$('#create_summary').val();
		 event.start={dateTime:ISODateString(start_date)};
		 event.end={dateTime:ISODateString(end_date)};
		 event.description=descr;
		 event.summary=summary1;
		 
		 var request = gapi.client.calendar.events.insert({
			  'calendarId': 'primary',
			  'resource': event
			});
			 request.execute(function(event) {
				 console.log(event)
			 // appendPre('Event created: ' + event.htmlLink);
			});  
	  }
  </script>
  
  
  
 <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
</script>
    <script type="text/javascript">
    
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '492177962308-k2o41d3pq28o60i3anjfuh4cfg2hbbne.apps.googleusercontent.com';
      var API_KEY = 'AIzaSyDUI8cEkEtHgW8QV2MW551e_k3SocX-EOw';

      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES ="https://www.googleapis.com/auth/calendar";

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
          signoutButton.style.display = 'block';
          listUpcomingEvents();
        } else {
         /*  authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none'; */
        }
      }
      $('#view_button').click(function(){
    	   $('#event_container').show();
    	});
   
    

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
        location.href=location.protocol+"//"+location.host+"/google-Calendar-JavaScript/login_page.jsp"
      }
   /**
       * Print the summary and start datetime/date of the next ten events in
       * the authorized user's calendar. If no events are found an
       * appropriate message is printed.
       */
      function listUpcomingEvents() {
        gapi.client.calendar.events.list({
          'calendarId': 'primary',
          'timeMin': (new Date(2018,08,01)).toISOString(),
          'showDeleted': false,
          'singleEvents': true,
          'maxResults': 10,
          'orderBy': 'startTime'
        }).then(function(response) {
          var events = response.result.items;
          console.log(events)
			if(events){
				for(var event of events){
					event.htmlLink=""
						event.summary=event.summary;
					var eventStr=JSON.stringify(event).replace(/\s+/g, '_');
					$("#create_event_body").attr("data-Createevent",eventStr);
					$('#event_container').append(" <li class='list-group-item'>"+event.summary+'<br>'+event.start.dateTime+'<br>'+event.description+"<button type='button' class='btn btn-outline-dark float-right' data-eventobj="+eventStr+" onclick='editEvent(this)'>Edit</button></li>");
				}
			}   else{
				alert('No Events')
			}      
         
        });
      
      
      }
      function editEvent(button){
    	  var event = $(button).data('eventobj');
    	  console.log(event)
		$('.modal-body').attr('data-event',JSON.stringify(event));
    	  $('#exampleModal').modal('show')
      }
     
   
      
      function ISODateString(d){
    	  function pad(n){return n<10 ? '0'+n : n}
    	  return d.getUTCFullYear()+'-'
    	       + pad(d.getUTCMonth()+1)+'-'
    	       + pad(d.getUTCDate())+'T'
    	       + pad(d.getUTCHours())+':'
    	       + pad(d.getUTCMinutes())+':'
    	       + pad(d.getUTCSeconds())+'Z'}
</script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
 
  </body>
</html>