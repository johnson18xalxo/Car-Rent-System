<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Login — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<section class="auth-section">
  <div class="auth-card">
    <div class="auth-header">
      <i class="fas fa-car-side auth-icon"></i>
      <h2>Welcome Back</h2>
      <p>Log in to manage your bookings</p>
    </div>

    <c:if test="${not empty error}">
      <div class="alert alert-error">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
      <div class="alert alert-success">${success}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post"
          id="loginForm" novalidate>
      <c:if test="${not empty redirectParam}">
        <input type="hidden" name="redirect" value="${redirectParam}"/>
      </c:if>

      <div class="form-group">
        <label>Email Address <span class="req">*</span></label>
        <input type="email" name="email" class="form-control"
               placeholder="username@example.com" required autofocus/>
      </div>
      <div class="form-group">
        <label>Password <span class="req">*</span></label>
        <div class="input-eye-wrap">
          <input type="password" name="password" id="loginPw" class="form-control"
                 placeholder="Your password" required/>
          <i class="fas fa-eye toggle-pw" data-target="loginPw"></i>
        </div>
      </div>
      <button type="submit" class="btn btn-primary btn-full">
        <i class="fas fa-sign-in-alt"></i> Login
      </button>
    </form>

    <p class="auth-alt">
      Don't have an account?
      <a href="${pageContext.request.contextPath}/register">Register here</a>
    </p>
  </div>
</section>

<%@ include file="footer.jsp" %>
