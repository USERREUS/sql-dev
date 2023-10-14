# Explanation of the ER-diagram:

**Orders** is an order table, it contains information about the order, it is a child in relation to other tables, it has a primary key on the track number field.
It is reasonable to put an unclustered index on the order date and payment number fields, because the data is stored for a long time and in a large volume.

Data integrity restrictions are provided by external keys.

**Customers** - the table of customers, contains information about customers, is a parent table in relation to orders, has a primary key on the field of the customer identifier.
It is reasonable to put an unclustered index on the fields of full name, as these fields will often be searched. The data is stored for a long time, in a large volume.

Limitations:
- age of customers over 18 years old; 
- phone number according to the RF template.

**Employees** - table of employees, contains information about employees, is parent to orders, has a primary key on the employee ID field. 
No indexes are required - small amount of data.

Restrictions:
- age of employees over 18 years old;
- phone number according to RF template;
- rating not more than 5.

**Parcels** - parcels table, contains information about parcels, is parent to orders, has a primary key on the parcel identifier field.
No indexes required - small amount of data.

Limitations:
- template parcel size; 
- weight not more than one kilogram.

**Delivery** - delivery table, contains information about delivery, has a primary key on the field of delivery identifier, is parent to orders.
Requires unclustered index to the delivery address, as this field will be searched most often, large amount of data.

**Payment** - payment table, contains all information on payment, is parent to orders, has primary key on payment identifier.
Other indexes are not required.

Limitations: the discount is not larger than the payment itself.