<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="My Account — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<div class="page-hero page-hero--sm">
  <div class="container">
    <h1>My Account</h1>
    <p>Manage your profile and security settings.</p>
  </div>
</div>

<section class="dashboard-section section">
  <div class="container">

    <!-- Dashboard tabs -->
    <div class="dashboard-tabs">
      <a href="${pageContext.request.contextPath}/my-bookings" class="dash-tab">
        <i class="fas fa-calendar-check"></i> My Bookings
      </a>
      <a href="${pageContext.request.contextPath}/my-account" class="dash-tab dash-tab--active">
        <i class="fas fa-user-cog"></i> My Account
      </a>
      <a href="${pageContext.request.contextPath}/search" class="dash-tab">
        <i class="fas fa-plus-circle"></i> New Booking
      </a>
    </div>

    <div class="account-grid">

      <!-- ── Profile Form ─────────────────────────────── -->
      <div class="account-card">
        <h3><i class="fas fa-user"></i> Profile Details</h3>

        <c:if test="${not empty successProfile}">
          <div class="alert alert-success">${successProfile}</div>
        </c:if>
        <c:if test="${not empty errorProfile}">
          <div class="alert alert-error">${errorProfile}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/my-account" method="post"
              id="profileForm" novalidate>
          <input type="hidden" name="action" value="updateProfile"/>

          <div class="form-group">
            <label>Full Name <span class="req">*</span></label>
            <input type="text" name="fullName" class="form-control"
                   value="${sessionScope.loggedUser.fullName}" required/>
          </div>
          <div class="form-group">
            <label>Email (cannot change)</label>
            <input type="email" class="form-control"
                   value="${sessionScope.loggedUser.email}" readonly/>
          </div>
          <div class="form-group">
            <label>Phone</label>
            <input type="tel" name="phone" class="form-control"
                   value="${sessionScope.loggedUser.phone}"/>
          </div>
          <div class="form-group">
            <label>Address</label>
            <textarea name="address" class="form-control" rows="3">${sessionScope.loggedUser.address}</textarea>
          </div>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Save Changes
          </button>
        </form>
      </div>

      <!-- ── Password Form ────────────────────────────── -->
      <div class="account-card">
        <h3><i class="fas fa-lock"></i> Change Password</h3>

        <c:if test="${not empty successPwd}">
          <div class="alert alert-success">${successPwd}</div>
        </c:if>
        <c:if test="${not empty errorPwd}">
          <div class="alert alert-error">${errorPwd}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/my-account" method="post"
              id="passwordForm" novalidate>
          <input type="hidden" name="action" value="updatePassword"/>

          <div class="form-group">
            <label>Current Password <span class="req">*</span></label>
            <div class="input-eye-wrap">
              <input type="password" name="oldPassword" id="oldPassword" class="form-control" required/>
              <i class="fas fa-eye toggle-pw" data-target="oldPassword"></i>
            </div>
          </div>
          <div class="form-group">
            <label>New Password <span class="req">*</span></label>
            <div class="input-eye-wrap">
              <input type="password" name="newPassword" id="newPassword" class="form-control" minlength="6" required/>
              <i class="fas fa-eye toggle-pw" data-target="newPassword"></i>
            </div>
          </div>
          <div class="form-group">
            <label>Confirm New Password <span class="req">*</span></label>
            <div class="input-eye-wrap">
              <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required/>
              <i class="fas fa-eye toggle-pw" data-target="confirmPassword"></i>
            </div>
          </div>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-key"></i> Update Password
          </button>
        </form>
      </div>

    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
