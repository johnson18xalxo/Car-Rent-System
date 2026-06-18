<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Book ${car.carName} — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<div class="page-hero page-hero--sm">
  <div class="container">
    <h1>Confirm Your Booking</h1>
    <p>Review the details and complete your reservation.</p>
  </div>
</div>

<section class="booking-section section">
  <div class="container">

    <c:if test="${not empty error}">
      <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="booking-grid">

      <!-- Car summary -->
      <div class="booking-summary">
        <h3>Your Selected Car</h3>
        <div class="summary-car">
          <img src="${pageContext.request.contextPath}/${car.imageUrl}"
               onerror="this.src='${pageContext.request.contextPath}/images/car-placeholder.png'"
               alt="${car.carName}"/>
          <div>
            <h4>${car.carName}</h4>
            <p>${car.brand} &bull; ${car.model}</p>
            <p><i class="fas fa-users"></i> ${car.seats} seats &nbsp;|&nbsp;
               <i class="fas fa-gas-pump"></i> ${car.fuelType}</p>
            <div class="summary-price">
              ₹<fmt:formatNumber value="${car.pricePerDay}" pattern="#,##0"/> <small>/day</small>
            </div>
          </div>
        </div>

        <div class="summary-dates">
          <div><i class="fas fa-calendar-alt"></i> Pick-up: <strong>${pickupDate}</strong></div>
          <div><i class="fas fa-calendar-check"></i> Drop-off: <strong>${dropoffDate}</strong></div>
        </div>

        <div class="summary-total" id="summaryTotal">
          <!-- Calculated by JS -->
        </div>
      </div>

      <!-- Booking form -->
      <div class="booking-form-wrap">
        <h3>Your Details</h3>
        <form action="${pageContext.request.contextPath}/booking" method="post"
              id="bookingForm" novalidate>
          <input type="hidden" name="carId"       value="${car.carId}"/>
          <input type="hidden" name="pickupDate"  value="${pickupDate}"  id="hdPickup"/>
          <input type="hidden" name="dropoffDate" value="${dropoffDate}" id="hdDropoff"/>
          <input type="hidden" name="pricePerDay" value="${car.pricePerDay}" id="pricePerDay"/>

          <div class="form-group">
            <label>Full Name <span class="req">*</span></label>
            <input type="text" class="form-control" name="fullName"
                   value="${sessionScope.loggedUser.fullName}" readonly/>
          </div>
          <div class="form-group">
            <label>Email <span class="req">*</span></label>
            <input type="email" class="form-control" name="emailDisplay"
                   value="${sessionScope.loggedUser.email}" readonly/>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label>Pick-up Date <span class="req">*</span></label>
              <input type="text" class="datepicker form-control" name="pickupDateDisplay"
                     id="bkPickup" value="${pickupDate}" autocomplete="off" required/>
            </div>
            <div class="form-group">
              <label>Drop-off Date <span class="req">*</span></label>
              <input type="text" class="datepicker form-control" name="dropoffDateDisplay"
                     id="bkDropoff" value="${dropoffDate}" autocomplete="off" required/>
            </div>
          </div>
          <div class="form-group">
            <label>Pick-up Location <span class="req">*</span></label>
            <input type="text" class="form-control" name="pickupLocation"
                   placeholder="e.g. Bilaspur Railway Station" required/>
          </div>
          <div class="form-group">
            <label>Additional Information</label>
            <textarea class="form-control" name="extraInfo" rows="3"
                      placeholder="Any special requests, child seat needed, etc."></textarea>
          </div>

          <button type="submit" class="btn btn-primary btn-full btn-lg">
            <i class="fas fa-check-circle"></i> Confirm Booking
          </button>
          <p class="form-note">
            By confirming you agree to our <a href="#">Terms &amp; Conditions</a>.
          </p>
        </form>
      </div>

    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
