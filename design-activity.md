What classes does each implementation include? Are the lists the same?
  Each implementation contains CartEntry, ShoppingCart and Order. (The lists are the same)

Write down a sentence to describe each class.
  CartEntry: one or more of the same item that has been added to the cart.
  ShoppingCart: a collection of all CartEntries with an additional function to calculate total price.
  Order: a container class for ShoppingCart that also calculates total price including sales tax.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  ShoppingCart and Order have a 1:1 relationship.
  ShoppingCart has many CartEntries.

What data does each class store? How (if at all) does this differ between the two implementations?
  CartEntry: stores unit_price and quantity in both implementations.
  ShoppingCart: 
    A: stores an array of CartEntries.
    B: stores an array of CartEntries, has a function to return price.
  Order:
    A: stores total_price, calculated by asking each CartEntry for price data.
    B: stores total_price by asking ShoppingCart for price.

What methods does each class have? How (if at all) does this differ between the two implementations?
  CartEntry: 
  ShoppingCart:
  Order:

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  A: retained in Order
  B: delegated to lower level classes
Does total_price directly manipulate the instance variables of other classes?
  A: yes
  B: no

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  A: Harder to modify. We would need to add additional logic to Order, to instruct it which price to apply for each CartEntry depending on quantity. We would also need to make an additional variable for CartEntry to store bulk price. 
  B: Easier to modify. We could add some logic to Cart's price function. We would also need to make an additional variable for CartEntry to store bulk price. 

Which implementation better adheres to the single responsibility principle?
  Implementation B

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  Implementation B

Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.
  This is not listed in my refactor ideas (which were mainly extra features, not improvements of existing features), but: the available_rooms function within Hotel contains logic that should be the responsibility of the Room class. Right now, Hotel is determining which rooms are available by accessing their instance variables of reservations and blocks, but ideally it would ask each room whether it's available and let the room make that determination by searching its own instance variables. I've edited the code to make that change by adding an is_available function to Room, and removing the overreaching logic from Hotel. 

  (A similar change could lighten up a few other functions within Hotel as well, such as reservations_by_date.)