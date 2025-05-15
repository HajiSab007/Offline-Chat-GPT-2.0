from transformers import GPT2LMHeadModel, GPT2Tokenizer

# Load pre-trained model and tokenizer
model_name = "gpt2"  # You can use "gpt2-medium", "gpt2-large", or "gpt2-xl" for more powerful models
model = GPT2LMHeadModel.from_pretrained(model_name)
tokenizer = GPT2Tokenizer.from_pretrained(model_name)

# Function to generate a response
def generate_response(prompt):
    inputs = tokenizer.encode(prompt, return_tensors="pt")
    outputs = model.generate(inputs, max_length=150, num_return_sequences=1, no_repeat_ngram_size=2, pad_token_id=tokenizer.eos_token_id)
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return response

# Chat function
def chat():
    print("Local ChatGPT: Hello! Type 'exit' to stop the conversation.")
    while True:
        user_input = input("You: ")
        if user_input.lower() == 'exit':
            print("Local ChatGPT: Goodbye!")
            break

        response = generate_response(user_input)
        print("Local ChatGPT: " + response)

if __name__ == "__main__":
    chat()
