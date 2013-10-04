$(document).ready(function(){

  $('.add-condition').on('click', function(e){
    condition_line = $(e.target).parent().find('.condition-line');
    new_index = "[" + (condition_line.parent().find('.new-condition').length + 1) +"]"
    condition_line.after('<div class="new-condition">' + condition_line.html().replace(/\[0\]/g, new_index) + '</div>');
  });

});