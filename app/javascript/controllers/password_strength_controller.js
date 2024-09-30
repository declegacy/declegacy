import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['password', 'result']

  connect() {
  }

  async onInput(e) {
    this.calculateTime()
  }

  async calculateTime() {
    const password = this.passwordTarget.value;

    // Dynamically determine the character set size
    const charSetSize = this.getCharSetSize(password);

    const guessesPerSecond = 1e9; // 1 billion guesses per second
    const passwordLength = password.length;

    // Calculate the total number of combinations
    const totalCombinations = Math.pow(charSetSize, passwordLength);

    // Calculate the time in seconds
    const timeInSeconds = totalCombinations / guessesPerSecond;

    // Convert time to years
    const timeInMinutes = timeInSeconds / 60;
    const timeInHours = timeInMinutes / 60;
    const timeInDays = timeInHours / 24;
    const timeInYears = timeInDays / 365;

    // Format large numbers
    const formattedTime = this.formatTime(timeInYears);

    let message = `It would take approximately ${formattedTime} to brute force this password.`
    if (timeInSeconds < 60) {
      message = "Password strength is very low. It would require less then a minute to brute force this password." 
    }

    if(timeInYears > 100) {
      this.resultTarget.classList.remove("text-red-500")
      this.resultTarget.classList.add("text-green-500")
    } else {
      this.resultTarget.classList.remove("text-green-500")
      this.resultTarget.classList.add("text-red-500")
    }

    this.resultTarget.innerText = message;
  }

  // Dynamically determine the character set size
  getCharSetSize(password) {
    let charSetSize = 0;
    const lower = /[a-z]/;
    const upper = /[A-Z]/;
    const digits = /[0-9]/;
    const symbols = /[!@#$%^&*(),.?":{}|<>]/;

    if (lower.test(password)) charSetSize += 26; // Lowercase letters
    if (upper.test(password)) charSetSize += 26; // Uppercase letters
    if (digits.test(password)) charSetSize += 10; // Digits
    if (symbols.test(password)) charSetSize += 32; // Symbols (common set)

    return charSetSize;
  }

  // Format the time into a human-readable form
  formatTime(years) {
    if (years >= 1e12) {
        return `${(years / 1e12).toFixed(2)} trillion years`;
    } else if (years >= 1e9) {
        return `${(years / 1e9).toFixed(2)} billion years`;
    } else if (years >= 1e6) {
        return `${(years / 1e6).toFixed(2)} million years`;
    } else if (years >= 1e3) {
        return `${(years / 1e3).toFixed(2)} thousand years`;
    } else if (years >= 1) {
        return `${years.toFixed(2)} years`;
    } else if (years >= 1 / 365) {
        return `${(years * 365).toFixed(2)} days`;
    } else if (years >= 1 / (365 * 24)) {
        return `${(years * 365 * 24).toFixed(2)} hours`;
    } else if (years >= 1 / (365 * 24 * 60)) {
        return `${(years * 365 * 24 * 60).toFixed(2)} minutes`;
    } else {
        return `${(years * 365 * 24 * 60 * 60).toFixed(2)} seconds`;
    }
  }
}
