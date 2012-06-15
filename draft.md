## model

* food
    name, price

* order
    food_id

* user
    email, password, name, orders, money

* history_order
    name, price, remain_price

## function

  The admin can add a couple of foods and press a button `start` to make the system can accept users to make orders. And after it starts, users can select multiple foods, every food is an order. And a user can have many orders. The user also can cancel an order before the system stop ordering.
  When the admin `stop` the system, users can not make changes to their orders. And the system will change the users money. And make theri orders as their history orders.
  The user can see his remain money, today orders, and history orders. Everyday the admin start the ordering, the system will clear all users `today orders`. 
  The admin can see the total remain money. He can edit the food list only before he starts the ordering. He can see all orders in a single list, and can stop the ordering. He can increase/decrease a user money.

## UI

* foods page
 
     name       price 
  [] foods1     10
  [] foods2     12
    ...
    --new foods--------

  accept mouse hover, show `edit/delete` options, update list by ajax.

## implementation tips

* popup quickadd dialog
    - content already in html 
    - show/hide the element
* replace an html element by ajax, i.e, quickedit dialog
    - :remote option
    - format.js, replace an element
    - absloute position style
* multiple operation on foods (checkbox group)
    - form_for(path, method)
    - check_box_tag 'food_ids[]'
    - param[:food_ids].each do id.to_i end

## experience

* html not support nested form
* has_many, belongs_to need add a user_id to order
* highlight table row:
   $(function() {
      $('table tbody tr').mouseover(function() {
         $(this).addClass('selectedRow');
      }).mouseout(function() {
         $(this).removeClass('selectedRow');
      }).click(function() {
         alert($('td:first', this).text());
      });
   });

## TODO

* money
* user money operation for admin
* system start/stop
* history orders, including money change
* how to write a singleton class i.e: system
* test edit/delete food when ordering

## QUESTION

* why hide shop with post method does not work, but get method can work ?
