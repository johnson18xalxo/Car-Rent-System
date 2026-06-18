/* ================================================================
   DriveEase — Main Application JavaScript
   Requires: jQuery 3.7+, jQuery UI 1.13+, jQuery Validate 1.19+
================================================================ */

$(function () {

  /* ── Hamburger menu ──────────────────────────────────────── */
  $('#hamburger').on('click', function () {
    $('#navLinks').toggleClass('open');
  });

  /* ── jQuery UI Datepicker ────────────────────────────────── */
  const todayDate = new Date();

  function initDatepicker(selector, minDate, onSelect) {
    $(selector).datepicker({
      dateFormat  : 'yy-mm-dd',
      minDate     : minDate || 0,
      changeMonth : true,
      changeYear  : true,
      showAnim    : 'slideDown',
      onSelect    : onSelect || function () {}
    });
  }

  // Home-page quick-search datepickers
  if ($('#qs-pickup').length) {
    initDatepicker('#qs-pickup', 0, function (date) {
      $('#qs-dropoff').datepicker('option', 'minDate', date);
    });
    initDatepicker('#qs-dropoff', 1);
  }

  // Search-results page datepickers
  if ($('#pickupDate').length) {
    initDatepicker('#pickupDate', 0, function (date) {
      $('#dropoffDate').datepicker('option', 'minDate', date);
    });
    initDatepicker('#dropoffDate', 1);
  }

  // Booking page datepickers (display-only, kept in sync with hidden fields)
  if ($('#bkPickup').length) {
    initDatepicker('#bkPickup', 0, function (date) {
      $('#hdPickup').val(date);
      $('#bkDropoff').datepicker('option', 'minDate', date);
      recalcTotal();
    });
    initDatepicker('#bkDropoff', 1, function (date) {
      $('#hdDropoff').val(date);
      recalcTotal();
    });
  }

  /* ── Booking total calculator ────────────────────────────── */
  function recalcTotal () {
    const pickup  = $('#hdPickup').val();
    const dropoff = $('#hdDropoff').val();
    const ppd     = parseFloat($('#pricePerDay').val());

    if (!pickup || !dropoff || isNaN(ppd)) return;

    const d1   = new Date(pickup);
    const d2   = new Date(dropoff);
    const diff = Math.max(1, Math.round((d2 - d1) / 86400000));
    const total = (diff * ppd).toFixed(2);

    $('#summaryTotal').html(
      '<i class="fas fa-rupee-sign"></i> Estimated Total: <span>₹' +
      parseFloat(total).toLocaleString('en-IN') +
      '</span><br/><small>' + diff + ' day(s) × ₹' +
      parseFloat(ppd).toLocaleString('en-IN') + '/day</small>'
    );
  }

  // Trigger on page load if dates are pre-filled
  recalcTotal();

  /* ── jQuery Validate — Login form ───────────────────────── */
  if ($('#loginForm').length) {
    $('#loginForm').validate({
      rules: {
        email    : { required: true, email: true },
        password : { required: true, minlength: 1 }
      },
      messages: {
        email    : { required: 'Email is required.', email: 'Enter a valid email.' },
        password : 'Password is required.'
      },
      errorElement : 'span',
      errorClass   : 'field-error',
      highlight    : function (el) { $(el).addClass('input-error'); },
      unhighlight  : function (el) { $(el).removeClass('input-error'); }
    });
  }

  /* ── jQuery Validate — Register form ────────────────────── */
  if ($('#registerForm').length) {
    $('#registerForm').validate({
      rules: {
        fullName        : { required: true, minlength: 3 },
        email           : { required: true, email: true },
        password        : { required: true, minlength: 6 },
        confirmPassword : { required: true, equalTo: '#regPw' }
      },
      messages: {
        fullName        : { required: 'Full name is required.', minlength: 'Minimum 3 characters.' },
        email           : { required: 'Email is required.', email: 'Enter a valid email.' },
        password        : { required: 'Password is required.', minlength: 'Minimum 6 characters.' },
        confirmPassword : { required: 'Please confirm your password.', equalTo: 'Passwords do not match.' }
      },
      errorElement : 'span',
      errorClass   : 'field-error',
      highlight    : function (el) { $(el).addClass('input-error'); },
      unhighlight  : function (el) { $(el).removeClass('input-error'); }
    });
  }

  /* ── jQuery Validate — Booking form ─────────────────────── */
  if ($('#bookingForm').length) {
    $('#bookingForm').validate({
      rules: {
        pickupDateDisplay  : { required: true },
        dropoffDateDisplay : { required: true },
        pickupLocation     : { required: true, minlength: 3 }
      },
      messages: {
        pickupDateDisplay  : 'Please select a pick-up date.',
        dropoffDateDisplay : 'Please select a drop-off date.',
        pickupLocation     : 'Please enter a pick-up location.'
      },
      submitHandler: function (form) {
        // Sync display dates to hidden fields before submit
        $('#hdPickup').val($('#bkPickup').val());
        $('#hdDropoff').val($('#bkDropoff').val());
        form.submit();
      },
      errorElement : 'span',
      errorClass   : 'field-error',
      highlight    : function (el) { $(el).addClass('input-error'); },
      unhighlight  : function (el) { $(el).removeClass('input-error'); }
    });
  }

  /* ── jQuery Validate — Profile form ─────────────────────── */
  if ($('#profileForm').length) {
    $('#profileForm').validate({
      rules: {
        fullName : { required: true, minlength: 3 }
      },
      messages: {
        fullName : { required: 'Name is required.', minlength: 'Minimum 3 characters.' }
      },
      errorElement : 'span',
      errorClass   : 'field-error',
      highlight    : function (el) { $(el).addClass('input-error'); },
      unhighlight  : function (el) { $(el).removeClass('input-error'); }
    });
  }

  /* ── jQuery Validate — Password form ────────────────────── */
  if ($('#passwordForm').length) {
    $('#passwordForm').validate({
      rules: {
        oldPassword     : { required: true },
        newPassword     : { required: true, minlength: 6 },
        confirmPassword : { required: true, equalTo: '#newPassword' }
      },
      messages: {
        oldPassword     : 'Please enter your current password.',
        newPassword     : { required: 'New password required.', minlength: 'Minimum 6 characters.' },
        confirmPassword : { required: 'Please confirm the new password.', equalTo: 'Passwords do not match.' }
      },
      errorElement : 'span',
      errorClass   : 'field-error',
      highlight    : function (el) { $(el).addClass('input-error'); },
      unhighlight  : function (el) { $(el).removeClass('input-error'); }
    });
  }

  /* ── jQuery Validate — Contact form ─────────────────────── */
  if ($('#contactForm').length) {
    $('#contactForm').validate({
      rules: {
        contactName  : { required: true, minlength: 2 },
        contactEmail : { required: true, email: true },
        subject      : { required: true },
        message      : { required: true, minlength: 20 }
      },
      messages: {
        contactName  : 'Please enter your name.',
        contactEmail : { required: 'Email is required.', email: 'Enter a valid email.' },
        subject      : 'Please enter a subject.',
        message      : { required: 'Message is required.', minlength: 'At least 20 characters.' }
      },
      submitHandler: function () {
        // No backend for contact; show success message
        $('#contactForm').html('<div class="alert alert-success"><i class="fas fa-check-circle"></i> Thank you! Your message has been received. We\'ll get back to you shortly.</div>');
      },
      errorElement : 'span',
      errorClass   : 'field-error',
      highlight    : function (el) { $(el).addClass('input-error'); },
      unhighlight  : function (el) { $(el).removeClass('input-error'); }
    });
  }

  /* ── Quick search form validation ───────────────────────── */
  if ($('#quickSearchForm').length) {
    $('#quickSearchForm').validate({
      rules: {
        pickupDate  : { required: true },
        dropoffDate : { required: true }
      },
      messages: {
        pickupDate  : 'Select a pick-up date.',
        dropoffDate : 'Select a drop-off date.'
      },
      errorElement : 'span',
      errorClass   : 'field-error'
    });
  }

  /* ── Password eye toggle ─────────────────────────────────── */
  $(document).on('click', '.toggle-pw', function () {
    const targetId = $(this).data('target');
    const $input   = $('#' + targetId);
    const isPass   = $input.attr('type') === 'password';
    $input.attr('type', isPass ? 'text' : 'password');
    $(this).toggleClass('fa-eye fa-eye-slash');
  });

  /* ── Fade-in cards on scroll ─────────────────────────────── */
  const observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.style.opacity    = '1';
        entry.target.style.transform  = 'translateY(0)';
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.car-card, .feature-card, .booking-card, .testi-card').forEach(function (el) {
    el.style.opacity    = '0';
    el.style.transform  = 'translateY(20px)';
    el.style.transition = 'opacity .4s ease, transform .4s ease';
    observer.observe(el);
  });

  /* ── Auto-dismiss alerts after 5s ───────────────────────── */
  setTimeout(function () {
    $('.alert-success, .alert-warn').fadeOut(600);
  }, 5000);

});

/* ── Inline style for validation errors (injected at runtime) */
const style = document.createElement('style');
style.textContent = `
  .field-error {
    color: #e53e3e;
    font-size: .78rem;
    display: block;
    margin-top: .3rem;
  }
  .input-error {
    border-color: #e53e3e !important;
    box-shadow: 0 0 0 3px rgba(229,62,62,.15) !important;
  }
`;
document.head.appendChild(style);
