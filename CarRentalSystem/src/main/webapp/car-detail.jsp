<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="${car.carName} — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<div class="page-hero page-hero--sm">
  <div class="container">
    <a href="${pageContext.request.contextPath}/search?pickupDate=${pickupDate}&dropoffDate=${dropoffDate}"
       class="back-link"><i class="fas fa-arrow-left"></i> Back to Results</a>
    <h1>${car.carName}</h1>
  </div>
</div>

<section class="car-detail-section section">
  <div class="container">
    <div class="car-detail-grid">

      <!-- Left: image -->
      <div class="car-detail__image">
        <img src="${pageContext.request.contextPath}/${car.imageUrl}"
             onerror="this.src='${pageContext.request.contextPath}/images/car-placeholder.png'"
             alt="${car.carName}"/>
      </div>

      <!-- Right: info + booking CTA -->
      <div class="car-detail__info">
        <span class="car-category car-category--lg">${car.category}</span>
        <h2>${car.carName}</h2>
        <p class="car-model-sub">${car.brand} &nbsp;&bull;&nbsp; ${car.model}</p>

        <p class="car-description">${car.description}</p>

        <div class="spec-grid">
          <div class="spec-item"><i class="fas fa-users"></i><span>${car.seats} Seats</span></div>
          <div class="spec-item"><i class="fas fa-gas-pump"></i><span>${car.fuelType}</span></div>
          <div class="spec-item"><i class="fas fa-car"></i><span>${car.category}</span></div>
          <div class="spec-item"><i class="fas fa-check-circle"></i>
            <span class="${car.available ? 'text-green' : 'text-red'}">
              ${car.available ? 'Available' : 'Unavailable'}
            </span>
          </div>
        </div>

        <div class="detail-price-box">
          <span class="detail-price-amt">₹<fmt:formatNumber value="${car.pricePerDay}" pattern="#,##0"/></span>
          <span class="detail-price-label">per day</span>
        </div>

        <c:if test="${car.available}">
          <a href="${pageContext.request.contextPath}/booking?carId=${car.carId}&pickupDate=${pickupDate}&dropoffDate=${dropoffDate}"
             class="btn btn-primary btn-lg btn-book">
            <i class="fas fa-calendar-plus"></i> Book This Car
          </a>

          <c:if test="${empty sessionScope.loggedUser}">
            <p class="login-hint">
              <i class="fas fa-info-circle"></i>
              You'll be asked to <a href="${pageContext.request.contextPath}/login">log in</a>
              before confirming your booking.
            </p>
          </c:if>
        </c:if>
        <c:if test="${!car.available}">
          <div class="alert alert-warn">This car is currently unavailable. Please choose another.</div>
        </c:if>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
