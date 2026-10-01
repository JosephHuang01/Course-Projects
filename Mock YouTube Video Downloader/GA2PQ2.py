# Jared Cambridge
# jcambridge3@student.gsu.edu
# Mya Harding
# kharding4@student.gsu.edu
# Joseph Huang
# jhuang31@student.gdu.edu

punctuationList = '"'

def main():
    while True:
        print("Option Menu:")
        print("1. Remove Punctuation")
        print("2. Count Word Frequency")
        print("3. Check Word Existence")
        print("4. Replace Word")
        print("5. Quit")
        
        choice = input("Select a choice (1/2/3/4/5): ")

        if choice == '1':
            line = input("Enter a line: ")
            punctuation = ""
            for char in line:
                if char not in punctuationList:
                    punctuation += char
            print("Text without punctuation: ", punctuation)
        
        elif choice == '2':
            line = input("Enter a line: ")
            count = input("Enter the word to count: ")
            wordCount = line.count(count)
            print("The word", count, "appears", wordCount, "times in the text.")
        
        elif choice == '3':
            line = input("Enter a line: ")
            existence = input("Enter the word to check for existence: ")
            if existence in line:
                print("The word", existence, "exists in the text.")
            else:
                print("The word", existence, "does not exist in the text.")
        
        elif choice == '4':
            line = input("Enter a line: ")
            oldWord = input("Enter the word to replace: ")
            newWord = input("Enter the new word: ")
            replacedText = line.replace(oldWord, newWord)
            print("Text after replacement: ", replacedText)
        
        elif choice == '5':
            print("Quitting the program. Goodbye!")
            break
        
        else:
            print("Invalid choice. Please enter a valid option (1/2/3/4/5).")

main()