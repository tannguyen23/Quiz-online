Create Database QuizManagement
GO
Use QuizManagement
GO
Create Table tblUser (
	Email			varchar(50)		Primary Key,
	[Name]			nvarchar(100)	not null,
	[Password]		char(64)		not null,
	[Role]			varchar(10)		not null,
	[Status]		bit				not null
)

Create Table tblRole (
	ID				varchar(10)		Primary Key,
	[Name]			varchar(50)		not null	
)

Create Table tblSubject (
	ID				varchar(50)		Primary Key,
	[Name]			nvarchar(100)	not null,
	[Time]			Time			not null,
	[Description]	nvarchar(500)	null,
	Mount			int				not null,
	[Status]		bit				not null
)

Create Table tblQuestion (
	ID				varchar(50)		Primary Key,
	Content			nvarchar(600)	not null,
	AnswerCorrect	varchar(50)		not null,
	CreateDate		DateTime		not null,
	SubjectID		varchar(50)		not null,
	[Status]		bit				not null
)

Create Table tblAnswer (
	ID				varchar(50)		Primary Key,
	Content			varchar(600)	not null,
	QuestionID		varchar(50)		not null
)

Create Table tblSubmission(
	ID				varchar(50)		Primary Key,
	UserID			varchar(50)		not null,
	Point			decimal(3,2)	not null,
	SubjectID		varchar(50)		not null,
	TimeSubmit		datetime		not null
)
Alter Table tblUser
Add Foreign Key (Role)
REFERENCES	tblRole(ID)

Alter Table tblQuestion
Add Foreign Key (SubjectID)
REFERENCES  tblSubject(ID)

Alter Table tblAnswer
Add Foreign Key(QuestionID)
REFERENCES tblQuestion(ID)

Alter Table tblSubmission
Add Foreign Key(UserID)
REFERENCES tblUser(Email)

Alter Table tblSubmission
Add Foreign Key(SubjectID)
REFERENCES tblSubject(ID)

Insert into tblRole(ID,Name) Values 
('ad','admin'),
('us','user')

Insert into tblUser(Email,Name,Password,Role,Status) Values 
('tanta2358@gmail.com',N'Nguyễn Ngọc Tấn', '8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92','us',1),
('tienxuan@gmail.com',N'Nguyễn Tiến Xuân','8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92','ad',1)

Insert into tblSubject(ID,Name,Time,Description,Mount,Status) Values
('PRJ321','Java Web Application','0:20:00','Java Web Application is used to create dynamic websites. Java provides support for web application through Servlets and JSPs. We can create a website with static HTML pages but when we want information to be dynamic, we need web application.',20,1),
('PRJ311','Java Desktop Application','0:10:00',null,10,1)

Insert into tblQuestion(ID,Content,AnswerCorrect,CreateDate,SubjectID,Status) Values 
('Q-1','JSP ________ let you insert arbitrary code into the servlet''s _JspService method (which is called by service).',
'A','20200618 10:34:09 AM','PRJ321',1),
('Q-2','Consider the HTML code below. Which of the following method calls can retrieve the "email" value sent from the browser? (Choose one)',
'C','20200618 10:34:09 AM','PRJ321',1),
('Q-3','Which of the following elements are used for error handling and are child elements of <web-app> of a deployment descriptor?',
'D','20200618 10:34:09 AM','PRJ321',1),
('Q-4','Consider the following taglibrary descriptor element
<tag>
<name>Hello</name>
<tag-class>com.abc.HelloTag</tag-class>
<body-content> ----- </body-content>
</tag>
Which of the following is NOT a valid value for <body-content> element?',
'D','20200618 10:34:09 AM','PRJ321',1),
('Q-5','Which statements are BEST describe isErrorPage attribute of <%@ page isErrorPage=....%> directive?',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-6','Which is the CORRECT statement about JMS?',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-7','Identify the parent element of <session-timeout> element in web.xml',
'D','20200618 10:34:09 AM','PRJ321',1),
('Q-8','EJB 3.0 specifications are first implemented in ______',
'A','20200618 10:34:09 AM','PRJ321',1),
('Q-9','You want to use a bean that is stored in com/enthu/GUI.ser file. Which of following statements correctly defines the tag that accesses the bean?',
'D','20200618 10:34:09 AM','PRJ321',1),
('Q-10','In which of the following cases will the method doEndTag() of a tag handler be invoked?',
'C','20200618 10:34:09 AM','PRJ321',1),
('Q-11','Which of the following statement correctly store an object associated with a name at a place where all the servlets/jsps of the same webapp participating in a session can access it? Assume that request, response, name, value etc. are references to objects of appropriate types.',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-12','Your web application named "FWorks" uses SpecialMath...class. This is an unbundled class and is not contained in any jar file. Where will you keep this class file?',
'C','20200618 10:34:09 AM','PRJ321',1),
('Q-13','Which of these is a correct fragment within the web-app element of deployment descriptor? Select the one correct answer',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-14','The form attribute _____specifies the server-side form handler, i.e., the program that handles the request',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-15','Which statements are BEST describe prefix attribute of <%@ taglib prefix=...%>directive of JSP file?',
'A','20200618 10:34:09 AM','PRJ321',1),
('Q-16','Which of the following statements is true? (Choose one)',
'A','20200618 10:34:09 AM','PRJ321',1),
('Q-17','What is output to the web page on the second access to the same instance of the following JSP? <html>
<body
<% int x = 0; %>
<%= x++%>
</body->
</html>',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-18','Your servlet may receive a request, which the servlet cannot handle. In such cases, you want to redirect the request to another resource which may or may not be a part of the same web application. Which of the following options can be used to achieve this objective?',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-19','Which technique is likely to return an initialization parameter for a JSP page?',
'D','20200618 10:34:09 AM','PRJ321',1),
('Q-20','Which HTTP method is used in FORM based Authentication?',
'D','20200618 10:34:09 AM','PRJ321',1),
('Q-21','What is the implication of using the HTTP GET method for a form submission?(Choose one)',
'A','20200618 10:34:09 AM','PRJ321',1),
('Q-22','Which of the following correctly represents the following JSP statement? Select one correct answer. <%=x%>',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-23','Consider the Servlet definition in a web.xml file below.
(see picture)
What will the following line of code return if present in the init() method of TestServlet?
getinitParameter(1);',
'C','20200618 10:34:09 AM','PRJ321',1),
('Q-24','You need to make sure that the response stream of your web application is secure. Which factor will you look at? (Choose one)',
'C','20200618 10:34:09 AM','PRJ321',1),
('Q-25','Consider the following HTML page code. Which method will be called on UploaderServlet when a user ....',
'D','20200618 10:34:09 AM','PRJ321',1),
('Q-26','Which statement is true about the EJB 3.0 stateful session beans?',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-27','Your web application logs a user in when she supplies username/password. At that time a session is created for the user. Your want to let the user to be logged in only for 20 minutes. The application should red...........',
'C','20200618 10:34:09 AM','PRJ321',1),
('Q-28','Study the statements about web.xml file.
1) The deployment descriptor file is called web.xml, and it must be located in the WEB-INF directory.
2) web.xml is in XML (extended markup language) format its root elementis <Web>.',
'A','20200618 10:34:09 AM','PRJ321',1),
('Q-29','Where the bean is declared using the following useBean tag accessible? <jsp:useBean id="jbean" class="com.jclass.JBean" />',
'C','20200618 10:34:09 AM','PRJ321',1),
('Q-30','You have declared a useBean tag as: <jsp:useBean id="man" class="animal. Human" scope="application"/> in which type of object will this bean be kept?',
'B','20200618 10:34:09 AM','PRJ321',1),
('Q-31','Swing components that don''t rely on native GUI are referred to as ___________.',
'A','20200618 10:34:09 AM','PRJ311',1),
('Q-32','__________ are referred to as heavyweight components.',
'A','20200618 10:34:09 AM','PRJ311',1),
('Q-33','Which of the following statements are NOT true?',
'B','20200618 10:34:09 AM','PRJ311',1),
('Q-34','Which of the following classes is a heavyweight component?',
'D','20200618 10:34:09 AM','PRJ311',1),
('Q-35','Which component cannot be added to a container?',
'C','20200618 10:34:09 AM','PRJ311',1),
('Q-36','Which of the following are subclasses of java.awt.Component?',
'B','20200618 10:34:09 AM','PRJ311',1),
('Q-37','What is best to describe the relationship between a container and a SWing GUI object in the container?',
'C','20200618 10:34:09 AM','PRJ311',1),
('Q-38','What is best to describe the relationship between a container and a layout manager?',
'B','20200618 10:34:09 AM','PRJ311',1),
('Q-39','What is best to describe the relationship between JComponent and JButton?',
'D','20200618 10:34:09 AM','PRJ311',1),
('Q-40','What is best to describe the relationship between Component and Color?',
'A','20200618 10:34:09 AM','PRJ311',1),
('Q-41','What is best to describe the relationship between Component and Font?',
'A','20200618 10:34:09 AM','PRJ311',1),
('Q-42','Which of the following classes are not in the java.awt package?',
'D','20200618 10:34:09 AM','PRJ311',1),
('Q-43','The correct order of the following three statements is ___________.

1. frame.setLocationRelativeTo(null);
2. frame.setSize(100, 200);
3. frame.setVisible(true);',
'C','20200618 10:34:09 AM','PRJ311',1),
('Q-44','Which of the following statements is for terminating the program when closing the frame?',
'A','20200618 10:34:09 AM','PRJ311',1),
('Q-45','Which of the following statements is for placing the frame''s upper left corner to (200, 100)?',
'C','20200618 10:34:09 AM','PRJ311',1),
('Q-46','What layout manager should you use so that every component occupies the same size in the container?',
'B','20200618 10:34:09 AM','PRJ311',1),
('Q-47','What should you use to position a Button within an application Frame so that the size of the Button is NOT affected by the Frame size?',
'A','20200618 10:34:09 AM','PRJ311',1),
('Q-48','Suppose a JFrame uses the GridLayout(2, 2). If you add six buttons to the frame, how many columns are displayed?',
'C','20200618 10:34:09 AM','PRJ311',1),
('Q-49','Suppose a JFrame uses the GridLayout(0, 2). If you add six buttons to the frame, how many columns are displayed?',
'B','20200618 10:34:09 AM','PRJ311',1),
('Q-50','Suppose a JFrame uses the GridLayout(2, 0). If you add six buttons to the frame, how many columns are displayed?',
'C','20200618 10:34:09 AM','PRJ311',1)



Insert into tblAnswer(ID,Content,QuestionID) Values
('Q-1-A','scriptlets','Q-1'),
('Q-1-B','expressions','Q-1'),
('Q-1-C','declarations','Q-1'),
('Q-1-D','definition','Q-1'),
('Q-2-A','getField("email") of HttpServletRequest','Q-2'),
('Q-2-B','getFormValue("email") of HttpServletRequest','Q-2'),
('Q-2-C','getParameter("email") of ServletRequest','Q-2'),
('Q-2-D','getParameters("email") ofHttpServlet','Q-2'),
('Q-3-A','<error-location>','Q-3'),
('Q-3-B','<error>','Q-3'),
('Q-3-C','<error-page>','Q-3'),
('Q-3-D','<error_page>','Q-3'),
('Q-4-A','empty','Q-4'),
('Q-4-B','tagdependent','Q-4'),
('Q-4-C','JSP','Q-4'),
('Q-4-D','generic','Q-4'),
('Q-5-A',' Any exceptions in the current page that are not caught are sent to the error page for processing. The error page implicit object exception references the original exception.','Q-5'),
('Q-5-B','Specifies if the current page is an error page that will be invoked in response to an error on another page. If the attribute value is true, the implicit object exception is created and references the original exception that occurred.','Q-5'),
('Q-5-C','Specifies the MIME type of the data in the response to the client. The default type is text/html.','Q-5'),
('Q-5-D','Specifies the class from which the translated JSP will be inherited. This attribute must be a fully qualified package and class name.','Q-5'),
('Q-6-A','JMS enhances access to email services','Q-6'),
('Q-6-B','JMS uses JNDI to find destination','Q-6'),
('Q-6-C','JMS uses JMX to create a connection Factory','Q-6'),
('Q-6-D','RMS enhances access to gmail services','Q-6'),
('Q-7-A','<session -configuration>','Q-7'),
('Q-7-B','<webapp>','Q-7'),
('Q-7-C','<session_config>','Q-7'),
('Q-7-D','<session-config>','Q-7'),
('Q-8-A','Java EE 5','Q-8'),
('Q-8-B','Java EE 4','Q-8'),
('Q-8-C','Java EE 3','Q-8'),
('Q-8-D','Java EE 6','Q-8'),
('Q-9-A','<jsp:useBean id="pref" name="com/enthu/GUI.ser" />','Q-9'),
('Q-9-B','<jsp:useBean id="pref" name="com.enthu.GUI" />','Q-9'),
('Q-9-C','<jsp:useBean id="pref" type="com/enthu/GUI.ser" />','Q-9'),
('Q-9-D','<jsp:useBean id="pref" beanName="com.enthu.GUI" type="com.enthu.GUI"/>','Q-9'),
('Q-10-A','It will be invoked only if doStartTag() and doAfterBody() complete successfully.','Q-10'),
('Q-10-B','This method is invoked if doStartTag () method returns true.','Q-10'),
('Q-10-C','It will be invoked only if doStartTag() or doAfterBody() return Tag.DO_END_TAG.','Q-10'),
('Q-10-D','It will be invoked in all case even if doStartTag() or doAfterBody() throw an exception.','Q-10'),
('Q-11-A','request.setAttribute(name, value);','Q-11'),
('Q-11-B','request.getSession().setAttribute(name, value).;','Q-11'),
('Q-11-C','response.setAttribute(name, value);','Q-11'),
('Q-11-D','request.setParameter(name, value)','Q-11'),
('Q-12-A','FWorks/WEB-INF','Q-12'),
('Q-12-B','FWorks/classes','Q-12'),
('Q-12-C','FWorks/WEB-INF/classes','Q-12'),
('Q-12-D','FWorks/WEB-INF/lib/classes','Q-12'),
('Q-13-A','<exception> <exception-type> mypackage.MyException </exception-type> <location> /error.jsp</location> </exception>','Q-13'),
('Q-13-B','<error-page> <exception-type> mypackage.MyException </exception-type> <location> /error.jsp</location> </error-page>','Q-13'),
('Q-13-C','<error-page> <exception> mypackage.MyException </exception-type> <location> /error.jsp </location> </error-page>','Q-13'),
('Q-13-D','<error-page> <exception-type> mypackage.MyException </exception-type> </error-page>','Q-13'),
('Q-14-A','name','Q-14'),
('Q-14-B','action','Q-14'),
('Q-14-C','localhost','Q-14'),
('Q-14-D','id','Q-14'),
('Q-15-A','Specifies the relative or absolute URI of the tag library descriptor.','Q-15'),
('Q-15-B','Specifies the required prefix that distinguishes custom tags from built-in tags. The prefix names jsp, jspx, java, javax, servlet, sun and sunw are reserved.','Q-15'),
('Q-15-C','Allows programmers to include their own new tags in the form of tag libraries. These libraries can be used to encapsulate functionality and simplify the coding of a JSP.','Q-15'),
('Q-15-D','The scripting language used in the JSP. Currently, the only valid value for this attribute is java.','Q-15'),
('Q-16-A','Session data is shared across multiple webapps in the same Webserver/servlet container.','Q-16'),
('Q-16-B','Any serializable object can be put into a session.','Q-16'),
('Q-16-C','To use session, the client browser must support cookies.','Q-16'),
('Q-16-D','A session can only be invalidated after "session-timeout" minutes of inactivity.','Q-16'),
('Q-17-A','3','Q-17'),
('Q-17-B','0','Q-17'),
('Q-17-C','1','Q-17'),
('Q-17-D','2','Q-17'),
('Q-18-A',' RequestDispatcher rd = request.getRequestDispatcher("some url");
rd.forward(request, response);','Q-18'),
('Q-18-B','response.sendRedirect("some url");','Q-18'),
('Q-18-C','request.sendRedirect("some url");','Q-18'),
('Q-18-D','RequestDispatcher rd = this.getServletContext().getRequestDispatcher("some url");
rd.forward(request, response);','Q-18'),
('Q-19-A','<%= request.getParameter("myParm") %>','Q-19'),
('Q-19-B','<% String s = getAttributef"myParm"); %>','Q-19'),
('Q-19-C','<%= getParameter("myParm") %>','Q-19'),
('Q-19-D','<% String s = getInitParameter("myParm"); %>','Q-19'),
('Q-20-A','GET','Q-20'),
('Q-20-B','HEAD','Q-20'),
('Q-20-C','FORM','Q-20'),
('Q-20-D','POST','Q-20'),
('Q-21-A','The parameters will be appended to the URL as a query string.','Q-21'),
('Q-21-B','You can only reply with the HEADER information in the response.','Q-21'),
('Q-21-C','None of the others','Q-21'),
('Q-21-D','You cannot send multiple values for one parameter to the server','Q-21'),
('Q-22-A','<jsp:expression=x/>','Q-22'),
('Q-22-B','<jsp:expression>x</jsp:expression>','Q-22'),
('Q-22-C','<jsp:statement>x</jsp:statement>','Q-22'),
('Q-22-D','<jsp: declaration>x</jsp:declaration>','Q-22'),
('Q-23-A','It Will return "eastern".','Q-23'),
('Q-23-B','Runtime error.','Q-23'),
('Q-23-C','Compilation error.','Q-23'),
('Q-23-D','It Will return null.','Q-23'),
('Q-24-A','authorization','Q-24'),
('Q-24-B','authentication','Q-24'),
('Q-24-C','data integrity','Q-24'),
('Q-24-D','automatic','Q-24'),
('Q-25-A','doPut','Q-25'),
('Q-25-B','doPost','Q-25'),
('Q-25-C','doHead','Q-25'),
('Q-25-D','doGet','Q-25'),
('Q-26-A','Its conversational state is retained across method invocations but NOT across transaction boundaries','Q-26'),
('Q-26-B','Its conversational state is retained across method invocations and transactions','Q-26'),
('Q-26-C','Its conversational state is lost after passivation unless the bean class saves it to a database','Q-26'),
('Q-26-D','All','Q-26'),
('Q-27-A','getMaxinactivelnterval()','Q-27'),
('Q-27-B','getCreation Time()','Q-27'),
('Q-27-C','getLastAccessTime()','Q-27'),
('Q-27-D','getLastAccessedTime()','Q-27'),
('Q-28-A','Only statement 1 is true','Q-28'),
('Q-28-B','Only statement 2 is true','Q-28'),
('Q-28-C','Both 1 and 2 are true','Q-28'),
('Q-28-D','Both 1 and 2 are not true','Q-28'),
('Q-29-A','within other servlets and JSP pages of the same web applications.','Q-29'),
('Q-29-B','throughout all future invocations of the JSP as long as the servlet engine is running.','Q-29'),
('Q-29-C','Throughout the remainder of the page.','Q-29'),
('Q-29-D','throughout all future invocations of the JSP as long as the session is not expired','Q-29'),
('Q-30-A','HttpSession','Q-30'),
('Q-30-B','Application Context','Q-30'),
('Q-30-C','ServletContext','Q-30'),
('Q-30-D','Servlet','Q-30'),
('Q-31-A','lightweight components','Q-31'),
('Q-31-B','heavyweight components','Q-31'),
('Q-31-C','GUI components','Q-31'),
('Q-31-D','non-GUI components','Q-31'),
('Q-32-A','AWT components','Q-32'),
('Q-32-B','Swing components','Q-32'),
('Q-32-C','GUI components','Q-32'),
('Q-32-D','Non-GUI components','Q-32'),
('Q-33-A','To distinguish new Swing component classes from their AWT counterparts, Swing GUI component classes are named with a prefix J.','Q-33'),
('Q-33-B','All Swing GUI components are lightweight.','Q-33'),
('Q-33-C','A user interface object such as (button, list) can appear in one container.','Q-33'),
('Q-33-D','A container such as JFrame is also a component.','Q-33'),
('Q-34-A','JButton','Q-34'),
('Q-34-B','JTextField','Q-34'),
('Q-34-C','JPanel','Q-34'),
('Q-34-D','JFrame','Q-34'),
('Q-35-A','JPanel','Q-35'),
('Q-35-B','JButton','Q-35'),
('Q-35-C','JFrame','Q-35'),
('Q-35-D','JComponent','Q-35'),
('Q-36-A','Container classes','Q-36'),
('Q-36-B','Swing user interface classes','Q-36'),
('Q-36-C','Helper classes such as Color and Font','Q-36'),
('Q-36-D','Layout managers','Q-36'),
('Q-37-A','Association','Q-37'),
('Q-37-B','Aggregation','Q-37'),
('Q-37-C','Composition','Q-37'),
('Q-37-D','Inheritance','Q-37'),
('Q-38-A','Association','Q-38'),
('Q-38-B','Aggregation','Q-38'),
('Q-38-C','Composition','Q-38'),
('Q-38-D','Inheritance','Q-38'),
('Q-39-A','Association','Q-39'),
('Q-39-B','Aggregation','Q-39'),
('Q-39-C','Composition','Q-39'),
('Q-39-D','Inheritance','Q-39'),
('Q-40-A','Association','Q-40'),
('Q-40-B','Aggregation','Q-40'),
('Q-40-C','Composition','Q-40'),
('Q-40-D','Inheritance','Q-40'),
('Q-41-A','Association','Q-41'),
('Q-41-B','Aggregation','Q-41'),
('Q-41-C','Composition','Q-41'),
('Q-41-D','Inheritance','Q-41'),
('Q-42-A','Color','Q-42'),
('Q-42-B','Font','Q-42'),
('Q-42-C','Component','Q-42'),
('Q-42-D','JFrame','Q-42'),
('Q-43-A','1 2 3','Q-43'),
('Q-43-B','1 3 2','Q-43'),
('Q-43-C','2 1 3','Q-43'),
('Q-43-D','3 2 1','Q-43'),
('Q-44-A','frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)','Q-44'),
('Q-44-B','frame.setDefaultCloseOperation(null)','Q-44'),
('Q-44-C','frame.setDefaultCloseOperation(JFrame.STOP_ON_CLOSE)','Q-44'),
('Q-44-D','frame.setDefaultCloseOperation(JFrame.TERMINATE_ON_CLOSE)','Q-44'),
('Q-45-A','frame.setLocation(100, 100)','Q-45'),
('Q-45-B','frame.setLocation(100, 200)','Q-45'),
('Q-45-C','frame.setLocation(200, 100)','Q-45'),
('Q-45-D','frame.setLocation(200, 200)','Q-45'),
('Q-46-A','a FlowLayout','Q-46'),
('Q-46-B','a GridLayout','Q-46'),
('Q-46-C','a BorderLayout','Q-46'),
('Q-46-D','any layout','Q-46'),
('Q-47-A','a FlowLayout','Q-47'),
('Q-47-B','a GridLayout','Q-47'),
('Q-47-C','the center area of a BorderLayout','Q-47'),
('Q-47-D','the East or West area of a BorderLayout','Q-47'),
('Q-48-A','1','Q-48'),
('Q-48-B','2','Q-48'),
('Q-48-C','3','Q-48'),
('Q-48-D','4','Q-48'),
('Q-49-A','1','Q-49'),
('Q-49-B','2','Q-49'),
('Q-49-C','3','Q-49'),
('Q-49-D','4','Q-49'),
('Q-50-A','1','Q-50'),
('Q-50-B','2','Q-50'),
('Q-50-C','3','Q-50'),
('Q-50-D','4','Q-50')




