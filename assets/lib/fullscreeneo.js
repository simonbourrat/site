/**
 *
 * Fullscreeneo
 *
 */
window.fullscreeneo = {
    init: function() {
        var $iframe = $('#vimeo_player_bgndVideo');

        $iframe.css({
            'position': 'absolute',
            'top' : 0,
            'left' : 0,
            'height': '100%',
            'width': '100%'
        }).wrap('<div class="fullscreeneo-wrap"><div class="fullscreeneo-video-container"></div></div>');


    },

    sizeEverything: function() {
        var max = function( a, b) {
            return a > b ? a : b;
        };

        var coverDimensions = function ( child_w, child_h, container_w, container_h ) {
            var scale_factor = max( container_w / child_w, container_h / child_h );

            return {
                width : Math.ceil(child_w * scale_factor),
                height: Math.ceil(child_h * scale_factor)
            };
        };

        dimensions = coverDimensions(16, 9, window.innerWidth, window.innerHeight);
        var $wrap = $('.fullscreeneo-wrap'),
            $el = $('.fullscreeneo-video-container');
        $el.css({
            'position': 'absolute',
            'width': dimensions.width,
            'padding-top': dimensions.height,
            'top': ( (window.innerHeight) - dimensions.height) * .5,
            'left': ( (window.innerWidth) - dimensions.width) * .5,
            'max-width': 'none'
        });

        $wrap.css({
            position: 'relative',
            overflow: 'hidden',
            width: window.innerWidth,
            height: window.innerHeight
        });
    }
};

window.addEventListener('resize', function() {
    console.log('Resize!');
    fullscreeneo.sizeEverything();
});