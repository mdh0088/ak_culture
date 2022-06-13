jQuery.noConflict();

jQuery(function ($) {

    'use strict';

    /**  site Loader Control **/
    (function loaderControl () {
        /**  show Loading bar **/
        window.showLoading = function () {
            if (!$('.loader').length) {
                $('body').prepend('<div class="loader"><div class="loader-body"><div class="loader-spinner"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div><div class="loader-text"><strong>���� 以� ������..</strong><span>議곌�留� 湲곕�ㅻ�� 二쇱�몄��.</span></div></div></div>');
            }
            $('.loader').removeClass('loaded').addClass('loading');
        };

        /**  hide Loading bar **/
        window.hideLoading = function () {
            $('.loader').addClass('loaded').removeClass('loading');
        };
    }());

    /**  Form element focusing **/
    (function toggleFormFocusing () {
        $(document).on('focusin', '.js-toggle-focusing', function () {
            $(this).addClass('focusing');
        })
            .on('focusout', '.js-toggle-focusing', function () {
                $(this).removeClass('focusing');
            });
    }());

    /**  Custom Selectbox **/
    (function setCustomSelecbox () {
        $(document).on('change', '.js-selectbox', function () {
            var text = $(this).children().filter(':selected').text();
            $(this).next('.input-select-caret').text(text);
        });

        $(window).on('load', function () {
            $('.js-selectbox').trigger('change');
        });
    }());

    /**  init Nano Scrollbar **/
    (function initNanoScrollbar () {
        $(".nano").nanoScroller({
            alwaysVisible: true
        });

        $(window).on('load', function () {
            $(".nano").nanoScroller();
        });
    }());

    /**  set Modal control **/
    (function setAKModal () {

        window.openModal = function (str) {
            var $target = $(str);

            if ($target.length) {
                $('body').addClass('modal-opened');
                $target.stop().fadeIn('fast').addClass('show');
            }
        }

        window.closeModal = function (str) {
            var $target = $(str);

            if ($target.length) {
                $target.stop().fadeOut('fast').removeClass('show');
                $('body').removeClass('modal-opened');
            }

            if ($target.find('form').length) {
                $target.find('form').each(function () {
                    this.reset();
                });
            }
        }

        $(document).on('click', '.js-open-modal', function (e) {
            e.preventDefault();

            var target = $(this).attr('data-target');

            if (typeof traget !== 'undefined') {
                openModal(target);
            }
        })
            .on('click', '.js-close-modal', function (e) {
                e.preventDefault();

                var $btn = $(this),
                    target = $btn.attr('data-target');

                if (typeof target !== 'undefined') {
                    closeModal(target);
                } else if (typeof target === 'undefined' && $btn.closest('.ak-modal').length) {
                    closeModal('#' + $btn.closest('.ak-modal').attr('id'));
                }
            });
    }());

    /**  set virtual keypad **/
    (function setVirtualKeypad () {
        $('.js-keypad .keypad-key').on('click', function (e) {
            var $input = $('.js-keypad-input'),
                $key = $(this),
                value = $input.val(),
                keytxt = $key.text(),
                result = value + keytxt;
            
            if ($key.hasClass('js-keypad-reset')) {
                $input.val('').trigger('change');
                return false;

            } else if ($key.hasClass('js-keypad-del')) {
                result = value.substring(0, value.length-1);
            }

            $input.val(result).trigger('change');
        });

        $('.js-pwd-keypad .keypad-key').on('click', function (e) {
            var $input = $('.js-keypad-pwd'),
                $key = $(this),
                keytxt = $key.text();
            
            if ($key.hasClass('js-keypad-reset')) {
                $input.val('').trigger('change').parent().removeClass('changed');
                return false;

            } else if ($key.hasClass('js-keypad-del')) {

                for(var i = $input.length-1, len = $input.length; i>-1; i--) {

                    if ($input.eq(i).val()) {
                        $input.eq(i).val('').trigger('change').parent().removeClass('changed');
                        return false;
                    }
                    
                }

                return false;
            }
            
            $input.each(function () {
                if (!this.value) {
                    this.value = keytxt;
                    $(this).parent().addClass('changed');
                    $(this).trigger('change');
                    return false;
                }
            });
        });
    }());

    /**  set input filter **/
    (function setInputFilter () {
        //�レ��only
        $(document).on('keyup', '.js-number-only', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        })
            //��湲�only
            .on('keyup', '.js-hangul-only',function () {
                this.value = this.value.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g, '');
            })
            //��臾�only
            .on('keyup', '.js-eng-only', function () {
                this.value = this.value.replace(/[^a-zA-Z ]/g, '');
            })
            //�대��쇰Ц��only
            .on('keyup', '.js-email-only', function () {
                this.value = this.value.replace(/[^A-Za-z0-9-_.@]/ig, '');
            });
    }());

    /** set Accordion Toggle **/
    (function setAccordionToggle () {
        $('.js-accordion .btn-toggle').on('click', function() {
            var $container = $(this).closest('.js-accordion');
            $container.toggleClass('expanded');
            $container.find('.nano').nanoScroller();
        });
    }());

    /* 20190521 ���� */
    /** Check all input item **/
    (function chkAllItem () {
        $(document).on('change', '.js-check-all', function () {
            var $this = $(this),
                IS_CHECKED = this.checked,
                NAME = $this.attr('name'),
                $inputs = $('.input-checkbox').filter('[name='+ NAME +']');

            $inputs.each(function () {
                this.checked = IS_CHECKED;
            });
        });

        $(document).on('change', '.input-checkbox', function () {
            if ($(this).hasClass('js-check-all')) {
                return false;
            }
            
            var $this = $(this),
                NAME = $this.attr('name'),
                IS_CHECKED = this.checked,
                $checkAll = $('.js-check-all').filter('[name='+ NAME +']'),
                $inputs =  $('.input-checkbox').filter('[name='+ NAME +']').not('.js-check-all'),
                cnt = 0;
            
            if (!$checkAll.length || NAME !== $checkAll.attr('name')) {
                return false;
            }

            if (IS_CHECKED) {
                $inputs.each(function () {
                    if (this.checked) {
                        cnt++;
                    }
                });
            }

            if (cnt === $inputs.length) {
                $checkAll[0].checked = true;
            } else {
                $checkAll[0].checked = false;
            }
        });
    }());

    /* 20190603 ���� */
    (function setTabList () {
        $('.tab-list-item').on('click', function (e) {
            e.preventDefault();
            var $this = $(this);
            var index = $this.index();
            var $container = $this.closest('.tab-container');
            var $tabPanels = $container.find('.tab-panel');
            var $active = $container.find('.on');

            if ($active.length) {
                $active.removeClass('on');
                $tabPanels.eq($active.index()).removeClass('show');
            }

            $this.addClass('on');
            $tabPanels.eq(index).addClass('show');
        });
    }());
    

}(jQuery));