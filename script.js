function validateForm() {
    var phone = document.getElementById("phone").value;
    var email = document.getElementById("email").value;
    
    // Simple email validation using a regular expression
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
      alert("Invalid email address");
      return false;
    }
    
    // Simple phone number validation (10 digits)
    var phonePattern = /^\d{10}$/;
    if (!phonePattern.test(phone)) {
      alert("Invalid phone number");
      return false;
    }
    
    return true;
  }
  