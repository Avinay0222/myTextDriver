const String baseURL = "http://172.93.54.177:3002";
const String imageBaseURL = "http://172.93.54.177:3002/uploads/";
const String sendOtpEndpoint = "/driver/signin"; //POST
const String veriftOtpEndpoint = "/driver/confirmation"; //POST
const String resendOtpEndpoint = "/driver/resendotp"; //POST
const String complpeteSignUpEndpoint = "/driver/complete"; //POST
const String logOutEndpoint = "/driver/logout"; //POST
const String getUserPofileEndpoint = "/driver/profile/preview"; //GET
const String updatePofileEndpoint = "/driver/profile/update"; //PUT
const String updloadProfileImageEndpoint = "/driver/profile/upload"; //PUT
const String updloadDocumentEndpoint = "/driver/document/upload"; //PUT
const String listOfUploadDocument = "/driver/list_of_upload_documents"; //GET
const String addVehicleDetail = "/driver/vehicle/add"; //POST
const String getVehicleType = "/driver/vehicle/types"; //GET
const String getVehicleList = "/driver/vehicles"; //GET
const String setCurrentLocation = "/driver/current_location"; //POST
const String getDriveModel = "/driver/preview/vehicle_docs"; //GET
const String setDriveModel = "/driver/vehicle/docs/save"; //POST
const String driveOnlineStatus = "/driver/ride_status"; //PUT
const String getRideRequest = "/driver/passenger/ride/request"; //GET
const String getActiveRides = "/driver/ride/accepted/list"; //GET
const String acceptRide = "/driver/ride/request/accepted"; //PUT
const String createDriverAcc = "/driver/owner/driver/create"; //POST
const String verifyDriverOTP = "/driver/owner/confirmation"; //POST
const String getDriverListAPI = "/driver/owner/driver/list"; //GET
const String getCanceledRidesListAPI = "/driver/ride/canceled/list"; //GET
const String getCompletedRidesListAPI = "/driver/ride/completed/list"; //GET
const String getOngoingRidesListAPI = "/driver/ride/inprogress/list"; //GET
const String getDriverSupportTicketAPI = "/driver/support/ticket/list"; //POST
const String OwnerSignUP = "/driver/owner/registration";
const String loginOwnerSignUP = "/driver/owner/login_with_password"; //POST
const String OtpVerify = "/driver/ride/request/inprogress";
const String rideCancel = "/driver/ride/request/canceled";
const String getTicketList = "/driver/support/ticket/list";
const String getOwnerTicketList = "/driver/owner/support/ticket/list";
const String createSupportTicket = "/driver/support/ticket/create";
const String createOwnerSupportTicket =
    "/driver/owner/support/ticket/create"; //POST
const String rideComplete = "/driver/ride/request/complete";
const String liveRides = "/driver/ride/request/inprogress";
const String inProgressRides = "/driver/ride/inprogress/list";
