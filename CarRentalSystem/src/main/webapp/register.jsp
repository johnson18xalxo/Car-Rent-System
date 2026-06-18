<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Register — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<section class="auth-section">
  <div class="auth-card auth-card--wide">
    <div class="auth-header">
      <i class="fas fa-user-plus auth-icon"></i>
      <h2>Create Account</h2>
      <p>Join DriveEase for instant bookings</p>
    </div>

    <c:if test="${not empty error}">
      <div class="alert alert-error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post"
          id="registerForm" novalidate>
      <div class="form-row">
        <div class="form-group">
          <label>Full Name <span class="req">*</span></label>
          <input type="text" name="fullName" class="form-control"
                 placeholder="Name Surname" required minlength="3"/>
        </div>
        <div class="form-group">
          <label>Phone Number</label>
          <input type="tel" name="phone" class="form-control"
                 placeholder="+91-9876543210"/>
        </div>
      </div>
      <div class="form-group">
        <label>Email Address <span class="req">*</span></label>
        <input type="email" name="email" class="form-control"
               placeholder="username@example.com" required/>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Password <span class="req">*</span></label>
          <div class="input-eye-wrap">
            <input type="password" name="password" id="regPw" class="form-control"
                   placeholder="Min. 6 characters" required minlength="6"/>
            <i class="fas fa-eye toggle-pw" data-target="regPw"></i>
          </div>
        </div>
        <div class="form-group">
          <label>Confirm Password <span class="req">*</span></label>
          <div class="input-eye-wrap">
            <input type="password" name="confirmPassword" id="regPwC" class="form-control"
                   placeholder="Repeat password" required/>
            <i class="fas fa-eye toggle-pw" data-target="regPwC"></i>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label>Address</label>
        <textarea name="address" class="form-control" rows="2"
                  placeholder="City, State (optional)"></textarea>
      </div>

      <button type="submit" class="btn btn-primary btn-full">
        <i class="fas fa-user-check"></i> Create Account
      </button>
    </form>

    <p class="auth-alt">
      Already have an account?
      <a href="${pageContext.request.contextPath}/login">Log in here</a>
    </p>
  </div>
</section>

<%@ include file="footer.jsp" %>
