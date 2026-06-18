<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="DriveEase — Premium Car Rentals India" scope="request"/>
<%@ include file="header.jsp" %>

<!-- ── HERO ──────────────────────────────────────────────────── -->
<section class="hero">
  <div class="hero-overlay"></div>
  <div class="hero-content">
    <span class="hero-eyebrow">India's Trusted Car Rental Service</span>
    <h1>The open road<br/><em>starts here.</em></h1>
    <p class="hero-sub">Choose from 50+ premium vehicles. Instant booking. No hidden charges.</p>
    <a href="${pageContext.request.contextPath}/search" class="btn btn-hero">
      Browse Cars <i class="fas fa-arrow-right"></i>
    </a>
  </div>
</section>

<!-- ── QUICK SEARCH ──────────────────────────────────────────── -->
<section class="quick-search-bar">
  <div class="container">
    <form action="${pageContext.request.contextPath}/search" method="get" class="quick-form" id="quickSearchForm">
      <div class="qs-field">
        <label><i class="fas fa-calendar-alt"></i> Pick-up Date</label>
        <input type="text" name="pickupDate" id="qs-pickup" class="datepicker" placeholder="dd-mm-yyyy" autocomplete="off" required/>
      </div>
      <div class="qs-field">
        <label><i class="fas fa-calendar-check"></i> Drop-off Date</label>
        <input type="text" name="dropoffDate" id="qs-dropoff" class="datepicker" placeholder="dd-mm-yyyy" autocomplete="off" required/>
      </div>
      <button type="submit" class="btn btn-search">
        <i class="fas fa-search"></i> Search Cars
      </button>
    </form>
  </div>
</section>

<!-- ── WHY DRIVEEASE ─────────────────────────────────────────── -->
<section class="features section">
  <div class="container">
    <h2 class="section-title">Why DriveEase?</h2>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-shield-alt"></i></div>
        <h3>Fully Insured</h3>
        <p>Every vehicle comes with comprehensive insurance. Drive worry-free, always.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-rupee-sign"></i></div>
        <h3>Best Prices</h3>
        <p>Transparent pricing from ₹1,500/day. No surprises at checkout.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-headset"></i></div>
        <h3>24/7 Support</h3>
        <p>Roadside assistance and customer support, any time of day or night.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-bolt"></i></div>
        <h3>Instant Booking</h3>
        <p>Confirm your reservation in under a minute. No paperwork required.</p>
      </div>
    </div>
  </div>
</section>

<!-- ── POPULAR CARS STRIP ─────────────────────────────────────── -->
<section class="popular section section-alt">
  <div class="container">
    <h2 class="section-title">Popular Picks</h2>
    <div class="popular-grid">
      <div class="pop-card">
        <div class="pop-img" style="background:#e8f0fe">
          <i class="fas fa-car fa-3x" style="color:#4f7aff"></i>
        </div>
        <div class="pop-info">
          <span class="pop-category">Sedan</span>
          <h4>Maruti Swift Dzire</h4>
          <span class="pop-price">from ₹1,800<small>/day</small></span>
        </div>
      </div>
      <div class="pop-card">
        <div class="pop-img" style="background:#fde8e8">
          <i class="fas fa-truck-monster fa-3x" style="color:#ff4f4f"></i>
        </div>
        <div class="pop-info">
          <span class="pop-category">SUV</span>
          <h4>Hyundai Creta</h4>
          <span class="pop-price">from ₹3,200<small>/day</small></span>
        </div>
      </div>
      <div class="pop-card">
        <div class="pop-img" style="background:#e8fde8">
          <i class="fas fa-charging-station fa-3x" style="color:#2db55d"></i>
        </div>
        <div class="pop-info">
          <span class="pop-category">Electric SUV</span>
          <h4>Tata Nexon EV</h4>
          <span class="pop-price">from ₹3,800<small>/day</small></span>
        </div>
      </div>
    </div>
    <div style="text-align:center;margin-top:2rem">
      <a href="${pageContext.request.contextPath}/search" class="btn btn-outline">View All Cars</a>
    </div>
  </div>
</section>

<!-- ── TESTIMONIALS ───────────────────────────────────────────── -->
<section class="testimonials section">
  <div class="container">
    <h2 class="section-title">What Our Customers Say</h2>
    <div class="testimonial-grid">
      <div class="testi-card">
        <p>"Booked a Creta for our Nainital trip. Seamless process, spotless car, zero hassle."</p>
        <span class="testi-name">— Priya Sharma, Delhi</span>
      </div>
      <div class="testi-card">
        <p>"Finally a rental service with honest pricing. The Innova was in perfect condition!"</p>
        <span class="testi-name">— Rahul Mehta, Mumbai</span>
      </div>
      <div class="testi-card">
        <p>"The app is super easy. Confirmed my booking in 2 minutes. Will book again."</p>
        <span class="testi-name">— Anita Verma, Raipur</span>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
