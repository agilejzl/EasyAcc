
root = window || @

class root.AjaxSearchView extends Backbone.View
    row_result_tpl = '
        <div class="msg">
            <span class="score"><%- score %></span>
            <h3><a href="<%- href %>" target="_blank"><%- content %></a></h3>
        </div>'

    events:
        'submit #new_reddit_form'  :  'ajax_search'
        'click .pager>a'           :  'turn_to_page'

    initialize: (options) ->
        _.extend(@, options)
        @row_compiled = _.template(row_result_tpl)

    ajax_search: (event) ->
        @count = 0
        @submit_form($(event.target))

    submit_form: ($form) ->
        @$("#result").html("")
        $.ajax
            type: 'GET'
            url: 'ajax_search'
            data:
                q: $form.find("#reddit_form_search").val().trim()
                count: @count
            success: (data, xhr, res) =>
                $src_list = $(data).find("#siteTable>.thing")
                _.each $src_list, (element, index) =>
                    current_row = @row_compiled
                        score: $(element).find(".rank").text()
                        href: $(element).find("a.title").attr("href")
                        content: $(element).find("a.title").text()
                    @$("#result").append(current_row)

                if @count < 25
                    @$(".pager>.prev").hide()
                else
                    @$(".pager>.prev").show()
                @$(".pager").attr("data-count", @count)
                if @$("#result>.msg").size() == 25
                    @$(".pager").show()
                else
                    @$(".pager").hide()
        false

    turn_to_page: (event) ->
        $button = $(event.target)
        current_count = ~~ $button.parent().attr("data-count")
        change_count = ~~ $button.attr("data-change")
        @count = current_count + change_count
        @submit_form(@$("#new_reddit_form"), @count)

