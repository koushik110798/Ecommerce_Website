<html>

<head>

<title>HTML Forms</title>

</head>

 

<body>

<strong>Forms (Introduction)</strong>

<hr />

Forms are created by using the <Form> tag in HTML.  There are two main

attributes to be concerned with:<br>

- <u>Action:</u> This tell the form where to pass the data.<br>

- <u>Method:</u> This tells the form how to pass the data (post or get). 'Post' will post the data to the page that the form is submitted to. 'Get' will pass the form fields to the designated page through the URL.<br><br>

Below is a list of form fields and important facts you need to know.

<br><br>

1. Text Box<br>

<input type="text"><br>

- Free form entry; accepts alphanumeric data.

<br><br>

2. Password Box<br>

<input type="password"><br>

- Similar to text box but does not display data being entered.

<br><br>

3. Text area<br>

<textarea rows="2" cols="20"></textarea><br>

- Similar to text box but allows for a larger area to enter data.<br>

- The 'rows' and 'cols' attributes control the size of your text area.

<br><br>

4. Check Box<br>

<input type="checkbox"><br>

- If checked, it will pass the value entered into the value attribute.<br>

- If unchecked, no value will be passed from this object.

<br><br>

5. Radio (Option) Button<br>

<input type="radio" name="gender"> Male<br>

<input type="radio" name="gender"> Female<br>

- A group of radio buttons will be mutually exclusive, meaning only one can be checked at a time.<br>

- Radio buttons are grouped by giving each button the same name, this creates an array of radio buttons.<br>

- If no option is selected, then no data will be passed.

<br><br>

6. Button<br>

<input type="button" value="My Button"><br>

- A button that appears on the form.<br>

- Can use button events to trigger javascript code.

<br><br>

7. Submit Button<br>

<input type="submit" value="Submit Button"><br>

- Similar to a normal button.<br>

- Automatically submits the form when clicked.

<br><br>

8. Reset Button<br>

<input type="reset" value="Reset Button"><br>

- Similar to a normal button.<br>

- When clicked, it will return all form fields to thier default values.

<br><br>

NOTE: If you have more than one object on your form with the same name, those objects will automatically be grouped into an array.

</body>

</html>

 