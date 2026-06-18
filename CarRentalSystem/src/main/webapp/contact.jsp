<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Contact Us — DriveEase" scope="request"/>
<%@ include file="header.jsp" %>

<div class="page-hero page-hero--sm">
  <div class="container">
    <h1>Get In Touch</h1>
    <p>We're here to help. Reach us any time.</p>
  </div>
</div>

<section class="section">
  <div class="container">
    <div class="contact-grid">

      <div class="contact-info">
        <h3>Contact Information</h3>
        <div class="contact-item">
          <i class="fas fa-map-marker-alt"></i>
          <div><strong>Head Office</strong><br/>Sector-7,Bhilai<br/>Chhattisgarh — 490006</div>
        </div>
        <div class="contact-item">
          <i class="fas fa-phone"></i>
          <div><strong>Phone</strong><br/>+91-9301655915</div>
        </div>
        <div class="contact-item">
          <i class="fas fa-envelope"></i>
          <div><strong>Email</strong><br/>support@carrental.in</div>
        </div>
        <div class="contact-item">
          <i class="fas fa-clock"></i>
          <div><strong>Hours</strong><br/>Mon–Sat: 8AM – 8PM<br/>Sunday: 10AM – 4PM</div>
        </div>
      </div>

      <div class="contact-form-wrap">
        <h3>Send Us a Message</h3>
        <c:if test="${not empty param.sent}">
          <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> Thank you! Your message has been received.
          </div>
        </c:if>
        <form id="contactForm" action="#" method="post" novalidate>
          <div class="form-row">
            <div class="form-group">
              <label>Your Name <span class="req">*</span></label>
              <input type="text" name="contactName" class="form-control"
                     placeholder="Johnson" required/>
            </div>
            <div class="form-group">
              <label>Email <span class="req">*</span></label>
              <input type="email" name="contactEmail" class="form-control"
                     placeholder="john@example.com" required/>
            </div>
          </div>
          <div class="form-group">
            <label>Subject <span class="req">*</span></label>
            <input type="text" name="subject" class="form-control"
                   placeholder="Booking enquiry, feedback…" required/>
          </div>
          <div class="form-group">
            <label>Message <span class="req">*</span></label>
            <textarea name="message" class="form-control" rows="5"
                      placeholder="Write your message…" required minlength="20"></textarea>
          </div>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-paper-plane"></i> Send Message
          </button>
        </form>
      </div>

    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>
