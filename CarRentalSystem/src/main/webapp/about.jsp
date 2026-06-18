<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="About Us — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<div class="page-hero page-hero--sm">
  <div class="container">
    <h1>About DriveEase</h1>
    <p>India's trusted car rental partner since 2018.</p>
  </div>
</div>

<section class="section">
  <div class="container">
    <div class="about-grid">
      <div class="about-text">
        <h2>Who We Are</h2>
        <p>DriveEase was founded with one simple mission: to make renting a car as easy as booking a cab.
           We believe that the freedom of the open road should be accessible to everyone — whether you're
           planning a weekend getaway, a business trip, or a cross-state adventure.</p>
        <p>Headquartered in Bilaspur, Chhattisgarh, we serve customers across 20+ cities in India with
           a fleet of 200+ vehicles ranging from compact hatchbacks to luxury SUVs and zero-emission EVs.</p>
        <h2 style="margin-top:2rem">Our Values</h2>
        <ul class="about-list">
          <li><i class="fas fa-check"></i> Transparency — No hidden charges, ever.</li>
          <li><i class="fas fa-check"></i> Safety — Every vehicle serviced and fully insured.</li>
          <li><i class="fas fa-check"></i> Convenience — Instant online booking, 24/7.</li>
          <li><i class="fas fa-check"></i> Sustainability — Growing EV fleet for a greener future.</li>
        </ul>
      </div>
      <div class="about-stats">
        <div class="stat-card"><span class="stat-num">50+</span><span class="stat-label">Vehicles</span></div>
        <div class="stat-card"><span class="stat-num">20+</span><span class="stat-label">Cities</span></div>
        <div class="stat-card"><span class="stat-num">10K+</span><span class="stat-label">Happy Customers</span></div>
        <div class="stat-card"><span class="stat-num">6</span><span class="stat-label">Years of Service</span></div>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
