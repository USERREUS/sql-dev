# Terms of Reference

---

## Description of the subject area:

The company sends **bundles** and **parcels** of various **sizes by regular** or **express** -shipping. 
**Customers** are provided with a unique **track number** to track **order**. 
**Cost** is determined by the size of the parcel and the **speed** of delivery.  
**Permanent** customers are given a **discount**.

---

## Entities:

The database stores information about orders, customers, price list with prices and discounts for regular customers, and employees. 

### Orders:
- tracking number
- customer code 
- date of order placement; 
- parcel type; 
- weight; 
- delivery method; 
- delivery address (city) 
- discount (is there or not); 
- code of the employee 
- code of the employee servicing this order; 
- order status; 
- confirmation of receipt from the customer.

#### Customers: 
- Individual customer code; 
- last name; 
- first name; 
- date of birth; 
- number of orders.
	
### Price list: 
- parcel size;
- type: 
	- parcel; 
	- small-sized; 
	- medium-sized; 
	- bulky; 
- weight (several categories: 1; 2; 3...);
- selected delivery method: 
	- regular;
	- express.

### Employees: 
- individual code; 
- surname; 
- first name; 
- mail; 
- date of birth; 
- rating.

---

## User Groups:
- Admin;
- employee;
- client.

Administrator has the right to enter and delete data about employees, change the price list.
Employee enters and deletes data about orders and clients, changes the order status, enters information about the availability of a discount.
Customer tracks the status of their orders, confirms delivery, can give positive or negative feedback to employees.

---

## Operating Rules:
Each order is serviced by one **employee** of the company. 
Customers can increase the **rating** of an employee by positively **rating** him/her: each positive rating increases the rating by 1 **point**. 
Alternatively, customers can give a negative rating and thereby lower the rating. 
Employees with a negative rating are dismissed.
The list of employees is sorted by rating: from the highest to the lowest, and orders are sorted by date: from the earliest date to the latest. 
The number of active (undelivered) orders of each customer is regularly counted and updated. 
If a customer has 3 or more active orders, then on the last one he gets a discount specified in the price list for the delivery price in this order.
If an order has the status "delivered" and delivery confirmation from the customer, it is deleted from the database. 
Employees whose rating is less than 0 must be terminated, i.e. their data is also deleted from the database provided they have no active, undelivered orders. 
Customers are deleted if they have no active orders.

---

_The PowerDesigner program is used for physical design._