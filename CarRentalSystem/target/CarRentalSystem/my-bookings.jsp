<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="My Bookings — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<div class="page-hero page-hero--sm">
  <div class="container">
    <h1>My Bookings</h1>
    <p>Track all your past and upcoming reservations.</p>
  </div>
</div>

<section class="dashboard-section section">
  <div class="container">

    <!-- Dashboard tabs -->
    <div class="dashboard-tabs">
      <a href="${pageContext.request.contextPath}/my-bookings"
         class="dash-tab dash-tab--active">
        <i class="fas fa-calendar-check"></i> My Bookings
      </a>
      <a href="${pageContext.request.contextPath}/my-account" class="dash-tab">
        <i class="fas fa-user-cog"></i> My Account
      </a>
      <a href="${pageContext.request.contextPath}/search" class="dash-tab">
        <i class="fas fa-plus-circle"></i> New Booking
      </a>
    </div>

    <!-- Alerts -->
    <c:if test="${not empty newBookingId}">
      <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        Booking #${newBookingId} confirmed! Check the details below.
      </div>
    </c:if>
    <c:if test="${not empty cancelMsg}">
      <div class="alert alert-warn"><i class="fas fa-info-circle"></i> ${cancelMsg}</div>
    </c:if>
    <c:if test="${not empty error}">
      <div class="alert alert-error">${error}</div>
    </c:if>

    <!-- Bookings list -->
    <c:choose>
      <c:when test="${empty bookings}">
        <div class="empty-state">
          <i class="fas fa-calendar-times fa-3x"></i>
          <h3>No bookings yet</h3>
          <p>You haven't made any reservations. Ready to hit the road?</p>
          <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">Browse Cars</a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="bookings-list">
          <c:forEach var="b" items="${bookings}">
            <div class="booking-card booking-card--${b.status == 'Confirmed' ? 'active' : b.status == 'Cancelled' ? 'cancelled' : 'completed'}">
              <div class="booking-card__img">
                <img src="${pageContext.request.contextPath}/${b.carImageUrl}"
                     onerror="this.src='${pageContext.request.contextPath}/images/car-placeholder.png'"
                     alt="${b.carName}"/>
              </div>
              <div class="booking-card__body">
                <div class="booking-card__top">
                  <div>
                    <h4>${b.carBrand} ${b.carName}</h4>
                    <p class="bk-model">${b.carModel}</p>
                  </div>
                  <span class="status-badge status-${b.status}">${b.status}</span>
                </div>
                <div class="booking-card__dates">
                  <span><i class="fas fa-map-marker-alt"></i> ${b.pickupLocation}</span>
                  <span><i class="fas fa-calendar-alt"></i> ${b.pickupDate}</span>
                  <span><i class="fas fa-arrow-right"></i></span>
                  <span><i class="fas fa-calendar-check"></i> ${b.dropoffDate}</span>
                </div>
                <div class="booking-card__footer">
                  <div>
                    <span class="bk-days">${b.rentalDays} day(s)</span>
                    <span class="bk-total">
                      Total: ₹<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0"/>
                    </span>
                  </div>
                  <div>
                    <span class="bk-id">#${b.bookingId}</span>
                    <c:if test="${b.status == 'Confirmed'}">
                      <a href="${pageContext.request.contextPath}/my-bookings?cancel=${b.bookingId}"
                         class="btn btn-danger btn-sm btn-cancel"
                         onclick="return confirm('Cancel booking #${b.bookingId}?')">
                        Cancel
                      </a>
                    </c:if>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>

  </div>
</section>

<%@ include file="footer.jsp" %>
