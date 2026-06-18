<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle" value="Find a Car — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<div class="page-hero page-hero--sm">
  <div class="container">
    <h1>Find Your Ride</h1>
    <p>Pick your dates, choose your car, hit the road.</p>
  </div>
</div>

<section class="search-section section">
  <div class="container">

    <!-- ── SEARCH FORM ───────────────────────────────── -->
    <div class="search-form-card">
      <form action="${pageContext.request.contextPath}/search" method="get" id="searchForm">
        <div class="search-row">
          <div class="form-group">
            <label><i class="fas fa-calendar-alt"></i> Pick-up Date</label>
            <input type="text" name="pickupDate" id="pickupDate" class="datepicker form-control"
                   value="${pickupDate}" placeholder="YYYY-MM-DD" autocomplete="off" required/>
          </div>
          <div class="form-group">
            <label><i class="fas fa-calendar-check"></i> Drop-off Date</label>
            <input type="text" name="dropoffDate" id="dropoffDate" class="datepicker form-control"
                   value="${dropoffDate}" placeholder="YYYY-MM-DD" autocomplete="off" required/>
          </div>
          <div class="form-group form-group--btn">
            <button type="submit" class="btn btn-primary btn-full">
              <i class="fas fa-search"></i> Search
            </button>
          </div>
        </div>
      </form>
    </div>

    <!-- ── RESULTS ───────────────────────────────────── -->
    <c:if test="${not empty error}">
      <div class="alert alert-error">${error}</div>
    </c:if>

    <c:choose>
      <c:when test="${empty cars}">
        <div class="empty-state">
          <i class="fas fa-car-crash fa-3x"></i>
          <h3>No cars available</h3>
          <p>Try different dates or check back soon.</p>
        </div>
      </c:when>
      <c:otherwise>
        <div class="results-header">
          <h2>
            <c:choose>
              <c:when test="${searched}">
                Available cars from <strong>${pickupDate}</strong> to <strong>${dropoffDate}</strong>
              </c:when>
              <c:otherwise>All Available Cars</c:otherwise>
            </c:choose>
          </h2>
          <span class="results-count">${fn:length(cars)} cars found</span>
        </div>

        <div class="cars-grid">
          <c:forEach var="car" items="${cars}">
            <div class="car-card">
              <div class="car-card__img">
                <img src="${pageContext.request.contextPath}/${car.imageUrl}"
                     onerror="this.src='${pageContext.request.contextPath}/images/car-placeholder.png'"
                     alt="${car.carName}"/>
                <span class="car-badge car-badge--${car.fuelType == 'Electric' ? 'ev' : 'fuel'}">${car.fuelType}</span>
              </div>
              <div class="car-card__body">
                <span class="car-category">${car.category}</span>
                <h3>${car.carName}</h3>
                <p class="car-model">${car.brand} &bull; ${car.model}</p>
                <div class="car-specs">
                  <span><i class="fas fa-users"></i> ${car.seats} seats</span>
                  <span><i class="fas fa-gas-pump"></i> ${car.fuelType}</span>
                </div>
                <div class="car-card__footer">
                  <div class="car-price">
                    <span class="price-amt">₹<fmt:formatNumber value="${car.pricePerDay}" pattern="#,##0"/></span>
                    <span class="price-unit">/day</span>
                  </div>
                  <a href="${pageContext.request.contextPath}/car-detail?carId=${car.carId}&pickupDate=${pickupDate}&dropoffDate=${dropoffDate}"
                     class="btn btn-primary btn-sm">View Details</a>
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
