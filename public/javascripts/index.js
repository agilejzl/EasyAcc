(function() {
  var root,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  root = window || this;

  root.AjaxSearchView = (function(superClass) {
    var row_result_tpl;

    extend(AjaxSearchView, superClass);

    function AjaxSearchView() {
      return AjaxSearchView.__super__.constructor.apply(this, arguments);
    }

    row_result_tpl = '<div class="msg"> <span class="score"><%- score %></span> <h3><a href="<%- href %>" target="_blank"><%- content %></a></h3> </div>';

    AjaxSearchView.prototype.events = {
      'submit #new_reddit_form': 'ajax_search',
      'click .pager>a': 'turn_to_page'
    };

    AjaxSearchView.prototype.initialize = function(options) {
      _.extend(this, options);
      return this.row_compiled = _.template(row_result_tpl);
    };

    AjaxSearchView.prototype.ajax_search = function(event) {
      this.count = 0;
      return this.submit_form($(event.target));
    };

    AjaxSearchView.prototype.submit_form = function($form) {
      this.$("#result").html("");
      $.ajax({
        type: 'GET',
        url: 'ajax_search',
        data: {
          q: $form.find("#reddit_form_search").val().trim(),
          count: this.count
        },
        success: (function(_this) {
          return function(data, xhr, res) {
            var $src_list;
            $src_list = $(data).find("#siteTable>.thing");
            _.each($src_list, function(element, index) {
              var current_row;
              current_row = _this.row_compiled({
                score: $(element).find(".rank").text(),
                href: $(element).find("a.title").attr("href"),
                content: $(element).find("a.title").text()
              });
              return _this.$("#result").append(current_row);
            });
            if (_this.count < 25) {
              _this.$(".pager>.prev").hide();
            } else {
              _this.$(".pager>.prev").show();
            }
            _this.$(".pager").attr("data-count", _this.count);
            if (_this.$("#result>.msg").size() === 25) {
              return _this.$(".pager").show();
            } else {
              return _this.$(".pager").hide();
            }
          };
        })(this)
      });
      return false;
    };

    AjaxSearchView.prototype.turn_to_page = function(event) {
      var $button, change_count, current_count;
      $button = $(event.target);
      current_count = ~~$button.parent().attr("data-count");
      change_count = ~~$button.attr("data-change");
      this.count = current_count + change_count;
      return this.submit_form(this.$("#new_reddit_form"), this.count);
    };

    return AjaxSearchView;

  })(Backbone.View);

}).call(this);
