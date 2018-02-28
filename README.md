# MVF API
An application to implement the following user stories;

priority -> **4** √
```
As an account holder,
I want to check my balance,
so that I know how much money I have.
```

priority -> **3** √
```
As an account holder,
I want to check the details being held about me,
so that I can make sure the correct details are being stored.
```

priority -> **1** √
```
As the customer,
I want to get a list of accounts in debt,
so that I can assess them for overdraft interest.
```

priority -> **2** √
```
As the customer,
I want to get the name, email address, telephone and balance for an account,
so that I can contact them and talk about their account.
```

priority -> **5** √
```
As an account holder,
I want to have to verify myself,
so that my information is safe.
```

To start app:
```
  $ ruby runapp.rb
```

If I had more time I would have looked into:

  - Testing the controller. The gets methods proved difficult to stub as it would cycle through an infinite loop if the input was unrecognisable and deliver unwanted responses. 

  - Refactoring. Some classes seemed to repeat code which would have been nice to take away. Possibly an AccountBase class that took methods to interpret it's data and extract information.

  - A printer class would have definitely been nice.
  
  - Also taken on the bonus stories.
