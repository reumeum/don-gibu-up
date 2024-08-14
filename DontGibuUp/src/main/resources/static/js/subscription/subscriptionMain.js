$(document).ready(function() {
    const items = $('.accordion-item');

    items.on('click', function() {
        const body = $(this).find('.accordion-body').first();

        $('.accordion-body').not(body).each(function() {
            $(this).removeClass('open')
                   .css('maxHeight', null)
                   .siblings('.accordion-header')
                   .find('.align-right')
                   .text('▼');
        });

        if (body.hasClass('open')) {
            body.removeClass('open')
                .css('maxHeight', null);
            $(this).find('.align-right').first().text('▼');
        } else {
            body.addClass('open')
                .css('maxHeight', body.prop('scrollHeight') + 'px');
            $(this).find('.align-right').first().text('▲');
        }
    });
});
