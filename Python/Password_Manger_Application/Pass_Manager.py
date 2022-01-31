#!/usr/bin/env python3
import time
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from base64 import b64encode, b64decode
from hashlib import md5
import re
"""
A Password Manager with logging capabilities.

Author: Lyle Astillo
"""

# Name of text file where credentials will be stored.
CREDENTIALS = 'credentials.txt'

# Function that checks if 'credentials.txt' already exists on the same directory of as the script.
# Also reates 'credentials.txt' if its the first time the script is used and store Passmanager credentials
# as well as other credentials enterd by user.
def check_cred_file(username, passwd):
   output = ''
   cred_file_contents = []
   server_names = []
   no_admin_account = True
   try:
      file = open(CREDENTIALS, 'r')
      file_reader = file.readlines()
      for lines in file_reader:     
         credentials = lines.split(':')
         cred_file_contents.append(credentials)
      for contents in cred_file_contents:
         server_names.append(contents[0].rstrip('\n'))
      for server in server_names:
         if server == 'Password Manager':
            output = '\nAccount already exists for Pass Manager 9000.\n'
            no_admin_account = False
      # If credential.txt exists, but no credentials for Pass Manager 9000, append credentials.   
      if no_admin_account == True:
         file = open(CREDENTIALS, 'a')
         file.write('Password Manager' + ':' + username + ':' + passwd + '\n')
         output = '\nAccount successfully created.\n'
   except FileNotFoundError:
      # Creates 'credentials.txt' which will be used as the database for the program.
      file = open(CREDENTIALS, 'w')
      file.write('Password Manager' + ':' + username + ':' + passwd + '\n')
      output = '\nAccount successfully created.\n'
   file.close()   
   return output

# Function that performs authentication for the Pass Manager 9000.
def authenticate(username, passwd):
   try:
      file = open(CREDENTIALS, 'r')
      file_reader = file.readlines()
      for lines in file_reader:
         credentials = lines.split(':')
         if credentials[0] == 'Password Manager':
            u_name = credentials[1]
            pwd = (credentials[2].rstrip('\n'))
      file.close()
      # Determine if credential input is the same as Password Manager credentials in credentials.txt
      if username == u_name and passwd == pwd:
         return True
      else:
         return False
   # Catch errors related to credential.txt not existing when attempting to login
   # and credential.txt existing without Pass Manager 9000 credential in it.
   except FileNotFoundError:
      return False
   except UnboundLocalError:
      return False

# Function that stores credentials to 'credentials.txt'
# Notify user if credentials for a server already exists in 'credentials.txt.
def store_creds(server_name, user_name, passwd):
   output = ''
   exists = False
   file = open(CREDENTIALS, 'r+')
   file_reader = file.readlines() 
   # SECURITY REQUIREMENTS 2
   # Prevents users from entering credentials for a server that already has one.
   for lines in file_reader:
      credentials = lines.split(':')
      if credentials[0] == server_name:
         output = '\nCredentials already exists for that sever.'
         exists = True
   # Stores server credentials to the database
   if exists == False:
      file.write(server_name + ':' + user_name + ':' + passwd + '\n')
      output = '\nCredentials successfully stored.'
   file.close()
   return output
      
# Function that retrives credentials for a given server from 'credentials.txt.'
# Notify user if no credentials exists for the server 'credentials.txt.'
def get_creds(server_name):
   output = ''
   u_name = ''
   encrptd_passwd = ''
   exists = False
   file = open(CREDENTIALS, 'r')
   file_reader = file.readlines()
   # Finds server name and return its associated username and password.
   for lines in file_reader:
      credentials = lines.split(':')
      if credentials[0] == server_name:
         u_name = credentials[1]
         encrptd_passwd = credentials[2].rstrip('\n')
         exists = True
   if exists == False:
      output = '\nNo credentials were found for that server.'
   else:
      output = '\nUsername: ' + u_name + ' Password: ' + pass_decryptor(encrptd_passwd)
   file.close()
   return output

# Function that updates credentials for a given server.
# Notify user if no credentials exists for the server 'credentials.txt.'
def update_creds(server_name, *args):
   output = ''
   user_input = []
   exists = False
   replaced = False
   file = open(CREDENTIALS, 'r+')
   file_reader = file.readlines()
   # Check if credentials exists for the given server in the database.
   # Clear database if credentials exists to prepare for rewrite.
   file.seek(0)
   for content in file_reader:
      credential_check = content.split(':')
      if credential_check[0] == server_name:
         exists = True
         file.truncate()
   # Store *args in user_input to determine which credentials tooption.
   for arguments in args:
      user_input.append(arguments)
   # Changes username for the given server.
   if user_input[0] == '1' and exists == True:
      for lines in file_reader:
         credentials = lines.split(':')
         if credentials[0] == server_name:
            credentials[1] = user_input[1]
            new_credentials = ':'.join(credentials)
            replaced = True
   # Changes password for the given server.
   elif user_input[0] == '2' and exists == True:
      for lines in file_reader:
         credentials = lines.split(':')
         if credentials[0] == server_name:
            credentials[2] = user_input[1] + '\n'
            new_credentials = ':'.join(credentials)
            replaced = True
   # Changes username and password for the given server.
   elif user_input [0] == '3' and exists == True:
      for lines in file_reader:
         credentials = lines.split(':')
         if credentials[0] == server_name:
            credentials[1] = user_input[1]
            credentials[2] = user_input[2] + '\n'
            new_credentials = ':'.join(credentials)
            replaced = True
   # Re-write credentials along with the updated credentials back to database.
   # Make it seem like the credentials for the given server were updated.
   if replaced == True:
      file.seek(0)
      file.write(new_credentials)
      for lines in file_reader:
         creds = lines.split(':')
         if creds[0] != server_name:
            updated_creds = ':'.join(creds)
            file.write(updated_creds)
   if replaced == True:
      output = '\nCredentials were successfully updated.'
   else:
      output = '\nNo credentials were found for that server.'
   file.close()
   return output
  
# Function that deletes the credentials for a given server.
# Notify user if no credentials exists for the server 'credentials.txt.'
def delete_creds(server_name):
   output = ''
   exists = False
   file = open(CREDENTIALS, 'r+')
   file_reader = file.readlines()
   # Check if credentials exists for the given server in the database.
   # Clear database if credentials exists to prepare for rewrite.
   file.seek(0)
   for content in file_reader:
      credential_check = content.split(':')
      if credential_check[0] == server_name:
         exists = True
         file.truncate()
   # Re-write credentials without the given server's credentail back to database.
   # Make it seem like the credentials for the given server were deleted.
   if exists == True:
      for lines in file_reader:
         credentials = lines.split(':')
         if credentials[0] != server_name:
            new_credentials = ':'.join(credentials)
            file.write(new_credentials)
   if exists == True:
      output = '\nCredentials were successfully deleted.'
   else:
      output = '\nNo credentials were found for that server.'
   file.close()
   return output

# Function that performs logging for Pass Manager 9000.
# Log file will be 'pass_man_log.txt.'
def logger(*args):
   LOG_FILE = 'pass_man_log.txt'
   user_input = []
   action = ''
   for arguments in args:
      user_input.append(arguments)
   try:
      file = open(LOG_FILE, 'a')
      # Logs success/fail login attempt to Pass Manager 9000.
      if type(user_input[0]) == bool:
         if user_input[0] == True:
            action = 'Login Success'
         else:
            action = 'Login Fail'
         file.write('{0:20}{1:<30}{2:<20}{3:<20}\n'.format(user_input[1], user_input[2], action, time.asctime()))
      # Logs server credential access attempts.
      else:
         action = 'Accessed'
         file.write('{0:<20}{1:<20}{2:<20}{3:<20}\n'.format(user_input[0], user_input[1], action, time.asctime()))
   # In case pass_man_log.txt does not exists in the directory
   except FileNotFoundError:
      file = open(LOG_FILE, 'w')
      # Logs success/fail login attempt to Pass Manager 9000.
      if type(user_input[0]) == bool:
         if user_input[0] == True:
            action = 'Login Success'
         else:
            action = 'Login Fail'
         file.write('{0:<20}{1:<30}{2:<20}{3:<20}\n'.format(user_input[1], user_input[2], action, time.asctime()))
      # Logs server credential access attempts.
      else:
         action = 'Accessed'
         file.write('{0:<20}{1:<20}{2:<20}{3:<20}\n'.format(user_input[0], user_input[1], action, time.asctime()))
   file.close()

# Function that performs password encryption for Pass Manager 9000 using AES CBC Mode.
def pass_encryptor(pt_passwd):
   key = md5('supersecretsauce'.encode()).hexdigest().encode()
   pt_password = pad(pt_passwd.encode(), AES.block_size)
   iv = key[8:AES.block_size+8]
   cipher = AES.new(key, AES.MODE_CBC, iv)
   encryptd_password = b64encode(cipher.encrypt(pt_password)).decode()
   return encryptd_password

# Function that decrypts passwords encrypted by pass_encryptor().
def pass_decryptor(encryptd_passwd):
   key = md5('supersecretsauce'.encode()).hexdigest().encode()
   encrypted_password = b64decode(encryptd_passwd.encode())
   iv = key[8:AES.block_size+8]
   cipher = AES.new(key, AES.MODE_CBC, iv)
   decryptd_password = unpad(cipher.decrypt(encrypted_password), AES.block_size).decode()
   return decryptd_password

# Function that checks passowrd complexity.
# Ensure passwords are 8 characters or longer,
# contain a number, upper and lower case letters, and special characters, 
def pass_strength_checker(passwd):
   nums = re.search(r'\d', passwd)
   lcase = re.search(r'[a-z]', passwd)
   ucase = re.search(r'[A-Z]', passwd)
   schars = re.search(r'[@$!%*#?&]', passwd)
   if nums == None or lcase == None or ucase == None or schars == None or len(passwd) < 8:
      return True

# Ensures that user does not use existing passwords in credentials.txt
def pass_finder(passwd):
   cred_file_contents = []
   encrptd_passwds = []
   user_input = pass_encryptor(passwd)
   try:
      file = open(CREDENTIALS, 'r')
      file_reader = file.readlines()
      for lines in file_reader:
         credentials = lines.split(':')
         cred_file_contents.append(credentials)
      for contents in cred_file_contents:
         encrptd_passwds.append(contents[2].rstrip('\n'))
      for password in encrptd_passwds:
         if password == user_input:
            return True
      file.close()
   # In case credential.txt does not exist when attempting to find password in database.
   except FileNotFoundError:
      return False

# Main function of the program.
def main():
   phase1 = True
   phase2 = False
   pass_man_u_name = ''
   print ('\nWelcome to PassManager 9000\n')
   # Prompts user to either login, create account, or quit.
   while phase1 == True:
      print('(1) Login\n(2) Create Account\n(3) Exit/Quit\n')
      enter = input('Enter the number based on what you would like to do: ')
      if enter == '1':
         pass_man_u_name = input('Username: ')
         pass_man_passwd = input('Password: ')
         encrptd_pass = pass_encryptor(pass_man_passwd)
         login = authenticate(pass_man_u_name, encrptd_pass)
         if login == True:
            phase1 = False
            phase2 = True
         else:
            print('\nInvalid Credentials\n')
         logger(login, pass_man_u_name, encrptd_pass)
      elif enter == '2':
         pass_man_u_name = input('Username: ')
         pass_man_passwd = input('Password: ')
         if len(pass_man_u_name) <= 1:
            print('\nInvalid Username\n')
         elif pass_strength_checker(pass_man_passwd) == True:
            print('\nPassword must be 8 characters or longer\nContain an upper and lowercase letters\n'
            + 'Contain a number and these special characters @$!%*#?&\n')
         elif pass_finder(pass_man_passwd) == True:
            print('\nPassword already used.\n')
         else:
            encrptd_pass = pass_encryptor(pass_man_passwd)
            print(check_cred_file(pass_man_u_name, encrptd_pass))
      elif enter == '3':
         print('\nGoodbye!\n')
         phase1 = False
      else:
         print('\nInvalid Option\n')
   # If user is authenticated, prompt user to either store, look-up, update,
   # or delete credentials, and if they want to exit the program.
   while phase2 == True:
      print ('\n(1) Store new credentials\n(2) Look up credentials\n' +
            '(3) Update crendentials\n(4) Delete credentials\n(5) Exit/Quit\n')
      choice = input('Enter the number based on what you would like to do: ')
      if choice == '1':
         s_name = input('Enter server name: ')
         u_name = input('Enter username: ')
         password = input ('Enter password: ')
         if len(u_name) <= 1:
            print('\nInvalid Username')
         elif pass_strength_checker(password) == True:
            print('\nPassword must be 8 characters or longer\nContain an upper and lowercase letters\n'
            + 'Contain a number and these special characters @$!%*#?&')
         elif pass_finder(password) == True:
            print('\nPassword already used.')
         else:
            encrptd_pass = pass_encryptor(password)
            print(store_creds(s_name, u_name, encrptd_pass))
      elif choice == '2':
         s_name = input('Enter server name: ')
         logger(pass_man_u_name, s_name)
         print(get_creds(s_name))
      elif choice == '3':
         s_name = input('Enter server name: ')
         # If user wants to update credentials for a server, this will prompt them to either
         # change the username, password, or both for a server.
         option = input('\nWhat would like to change? (1) Username (2) Password (3) Both: ')
         if option == '1':
            new_u_name = input('\nEnter new username: ')
            if len(new_u_name) <= 1:
               print('\nInvalid username')
            else:
               print(update_creds(s_name, option, new_u_name))
         elif option == '2':
            new_password = input('\nEnter new password: ')
            if pass_strength_checker(new_password) == True:
               print('\nPassword must be 8 characters or longer\nContain an upper and lowercase letters\n'
               + 'Contain a number and these special characters @$!%*#?&')
            elif pass_finder(new_password) == True:
               print('\nPassword already used.\n')
            else:
               encrptd_pass = pass_encryptor(new_password)
               print(update_creds(s_name, option, encrptd_pass))
         elif option == '3':
            new_u_name = input('\nEnter new username: ')
            new_password = input('Enter new password: ')
            if len(new_u_name) <= 1:
               print('\nInvalid Username')
            elif pass_strength_checker(new_password) == True:
               print('\nPassword must be 8 characters or longer\nContain an upper and lowercase letters\n'
               + 'Contain a number and these special characters @$!%*#?&')
            elif pass_finder(new_password):
               print('\nPassword already used.')
            else:
               encrptd_pass = pass_encryptor(new_password)
               print(update_creds(s_name, option, new_u_name, encrptd_pass))
         else:
            print('\nInvalid option')
      elif choice == '4':
         s_name = input('Enter server name: ')
         print(delete_creds(s_name))
      elif choice == '5':
         print('\nGoodbye!\n')
         phase2 = False
      else:
         print('\nInvalid option')

# Driver
if __name__ == '__main__':
   main()