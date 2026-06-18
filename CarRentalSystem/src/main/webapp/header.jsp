<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>${not empty pageTitle ? pageTitle : 'DriveEase — Car Rentals'}</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>

  <!-- jQuery UI CSS (for datepicker) -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css"/>

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <!-- App CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<!-- ═══════════════════════════════════════════════════════════════
     NAVBAR
════════════════════════════════════════════════════════════════ -->
<nav class="navbar">
  <div class="nav-container">
    <a href="${pageContext.request.contextPath}/index.jsp" class="brand">
      <i class="fas fa-car-side"></i> Car Rent System
    </a>

    <button class="hamburger" id="hamburger" aria-label="Toggle menu">
      <span></span><span></span><span></span>
    </button>

    <ul class="nav-links" id="navLinks">
      <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/search">Find a Car</a></li>
      <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
      <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>

      <c:choose>
        <c:when test="${not empty sessionScope.loggedUser}">
          <!-- ─── Logged-in links ─── -->
          <li class="nav-divider"></li>
          <li class="nav-user-name"><i class="fas fa-user-circle"></i> ${sessionScope.userName}</li>
          <li><a href="${pageContext.request.contextPath}/my-bookings"><i class="fas fa-calendar-check"></i> My Bookings</a></li>
          <li><a href="${pageContext.request.contextPath}/my-account"><i class="fas fa-cog"></i> My Account</a></li>
          <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav-logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </c:when>
        <c:otherwise>
          <!-- ─── Guest links ─── -->
          <li><a href="${pageContext.request.contextPath}/login"    class="btn-nav-login">Login</a></li>
          <li><a href="${pageContext.request.contextPath}/register" class="btn-nav-register">Register</a></li>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
</nav>

<main class="main-content">
