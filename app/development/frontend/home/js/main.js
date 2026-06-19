(function ($) {
    "use strict";
    
    // Dropdown on mouse hover
    $(document).ready(function () {
        function toggleNavbarMethod() {
            if ($(window).width() > 992) {
                $('.navbar .dropdown').on('mouseover', function () {
                    $('.dropdown-toggle', this).trigger('click');
                }).on('mouseout', function () {
                    $('.dropdown-toggle', this).trigger('click').blur();
                });
            } else {
                $('.navbar .dropdown').off('mouseover').off('mouseout');
            }
        }
        toggleNavbarMethod();
        $(window).resize(toggleNavbarMethod);
    });


    // Date and time picker
    $('.date').datetimepicker({
        format: 'L'
    });
    $('.time').datetimepicker({
        format: 'LT'
    });
    
    
    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });


    // Portfolio isotope and filter
    var portfolioIsotope = $('.portfolio-container').isotope({
        itemSelector: '.portfolio-item',
        layoutMode: 'fitRows'
    });
    $('#portfolio-flters li').on('click', function () {
        $("#portfolio-flters li").removeClass('active');
        $(this).addClass('active');

        portfolioIsotope.isotope({filter: $(this).data('filter')});
    });


    // Testimonials carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        items: 1,
        dots: false,
        loop: true,
    });
    
})(jQuery);


// Modal login Toggle lihat/sembunyikan password
document.getElementById('togglePassword').addEventListener('click', function () {
    const passwordInput = document.getElementById('inputPassword');
    const icon = document.getElementById('iconTogglePassword');
    const isPassword = passwordInput.getAttribute('type') === 'password';

    passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
    icon.classList.toggle('bi-eye-fill');
    icon.classList.toggle('bi-eye-slash-fill');
});

// Validasi dasar pakai Bootstrap validation classes
const formLogin = document.getElementById('formLogin');
formLogin.addEventListener('submit', function (e) {
    if (!formLogin.checkValidity()) {
        e.preventDefault();
        e.stopPropagation();
    }
    formLogin.classList.add('was-validated');

    // ganti baris di bawah dengan fetch() ke endpoint Flask, misal POST /login
    // Lihat catatan integrasi backend di bawah.
});

document.addEventListener('DOMContentLoaded', function () {
        const carouselElement = document.getElementById('header-carousel');
        
        // Inisialisasi Bootstrap Carousel dengan interval 15 detik
        const carousel = new bootstrap.Carousel(carouselElement, {
            interval: 5000,  // 15 detik
            ride: 'carousel',
            pause: false      // Jangan pause saat hover (opsional)
        });
    });


