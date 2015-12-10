/* Author:

*/

/**
 * Example 1
 * Add anchors to all h1's on the page
 */
 anchors.options = {
   visible: 'hover',
   placement: 'left',
   icon: ''
 };
 function showHiddenParagraphs() {
  $("p.hidden").fadeIn(500);
}
 window.onload = function() {
   anchors.add('h3');

//setTimeout(showHiddenParagraphs, 1000);
 };
