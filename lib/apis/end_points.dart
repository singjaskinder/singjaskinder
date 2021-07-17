class EndPoints {
  static const googleLogin = 'user/auth/google';
  static const getCheckEmail = 'user/email';
  static const getCheckPhone = 'driver/phone';
  static const postRegister = 'driver/signup';
  static const postSendOtpEmail = 'driver/otp/password';
  static const postConfirmOtp = 'driver/confirmotp';
  static const putResetPassword = 'driver/reset/password';
  static const updatePassword = 'driver/password';
  static const postLogin = 'driver/login';
  static const putUpdateDriver = 'driver/update';
  static const getDriverDetails = 'driver';
  static const getVehicleCategory = 'user/getVehicleCategory';
  static const postAddVehicle = 'driver/vehicle/addVehicle';
  static const getVehicles = 'driver/vehicle/all';
  static const putUpdateVehicle = 'driver/vehicle/update';
  static const deleteUpdateVehicle = 'driver/vehicle';
  static const postReview = 'driver/review';
  static const getReviews = 'driver/reviews';
  static const bidJob = 'driver/job/bid';
  static const getBiddedJobs = 'driver/myBiddings';
  static const putJobCancel = 'driver/rejectJob';
  static const putJobProgress = 'driver/setInProgress';
  static const putJobCompleted = 'driver/setCompleted';
  static const getAnalyticsWeek = 'driver/analytics/week';
  static const getAnalyticsMonth = 'driver/analytics/month';
}
