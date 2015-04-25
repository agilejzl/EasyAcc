
root = window || @

class root.AjaxSearchView extends Backbone.View
    row_result_tpl = '
        <div class="msg">
            <span class="score"><%- score %></span>
            <h3><a href="<%- href %>" target="_blank"><%- content %></a></h3>
        </div>'

    events:
        'submit #new_reddit_form'  : 'ajax_search'

    initialize: (options) ->
        _.extend(@, options)
        @row_compiled = _.template(row_result_tpl)

    ajax_search: (event) ->
        $form = $(event.target)
        $("#result").html("")
        $.ajax
            type: 'GET'
            url: 'ajax_search'
            data:
                q: $form.find("#reddit_form_search").val().trim()
            success: (data, xhr, res) =>
                $src_list = $(data).find("#siteTable>.thing")
                _.each $src_list, (element, index) =>
                    current_row = @row_compiled
                        score: $(element).find(".rank").text()
                        href: $(element).find("a.title").attr("href")
                        content: $(element).find("a.title").text()
                    $("#result").append(current_row)
        false

