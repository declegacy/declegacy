import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'rawContent', 'encryptionPassword', 'cryptedContent', "codeTemplate", "generatedDecryptionCode", "generatedContentContainer", "decryptedContent", "errorContent"]

  connect() {
    if(this.hasRawContentTarget) {
      this.tryToEncrypt() 
    } else {
      this.populateCode(this.cryptedContentTarget.value)
    }

    this.encryptionKey = null;
  }

  async tryToDecrypt(event) {
    if(event) {
      event.preventDefault();
    }

    let decrypted = null
    try {
      decrypted = await this.decryptText(this.encryptionPasswordTarget.value, this.cryptedContentTarget.value)
    }
    catch(err) {
      this.decryptedContentTarget.style.display = "none"
      this.errorContentTarget.style.display = "block"
    }
    
    if(decrypted) {
      this.decryptedContentTarget.innerHTML = decrypted
      this.decryptedContentTarget.style.display = "block"
      this.errorContentTarget.style.display = "none"
    }
  }

  async populateCode(encrypted) {
    this.generatedDecryptionCodeTarget.innerHTML = this.codeTemplateTarget.innerHTML.replace("{{encrypted_content}}", encrypted)
  }

  async tryToEncrypt(event) {
    if(event) {
      event.preventDefault();
    }
   
    const password = this.encryptionPasswordTarget.value;
    const rawContent = this.rawContentTarget.value;

    if (password && rawContent) {
      this.generatedContentContainerTarget.style.display = "block"
    } else {
      this.generatedContentContainerTarget.style.display = "none"
    }

    // const cryptedContent = this.cryptedContentTarget.value;

    // if (cryptedContent) {
    //   const decrypted = await this.decryptText(password, JSON.parse(cryptedContent));
    //   this.rawContentTarget.value = decrypted;
    // } else if (rawContent) {
      const encrypted = await this.encryptText(password, rawContent);
      this.cryptedContentTarget.value = encrypted;
    // }
    
    this.populateCode(encrypted)

  }
  async encryptText(password, text) {
    const enc = new TextEncoder();
    const encodedPassword = enc.encode(password);
    const encodedText = enc.encode(text);

    const key = await crypto.subtle.importKey(
      'raw', 
      encodedPassword, 
      { name: 'PBKDF2' }, 
      false, 
      ['deriveKey']
    );

    const derivedKey = await crypto.subtle.deriveKey(
      {
        name: 'PBKDF2',
        salt: enc.encode('salt'),
        iterations: 100000,
        hash: 'SHA-256'
      },
      key,
      { name: 'AES-GCM', length: 256 },
      false,
      ['encrypt']
    );

    const iv = crypto.getRandomValues(new Uint8Array(12));

    const encryptedContent = await crypto.subtle.encrypt(
      {
        name: 'AES-GCM',
        iv: iv
      },
      derivedKey,
      encodedText
    );

    const base64Iv = btoa(String.fromCharCode(...iv));
    const base64Content = btoa(String.fromCharCode(...new Uint8Array(encryptedContent)));

    return `${base64Iv}:${base64Content}`;
  }

  async decryptText(password, encrypted) {
    const enc = new TextEncoder();
    const encodedPassword = enc.encode(password);

    const [base64Iv, base64Content] = encrypted.split(':');
    const iv = new Uint8Array(atob(base64Iv).split('').map(char => char.charCodeAt(0)));
    const encryptedContent = new Uint8Array(atob(base64Content).split('').map(char => char.charCodeAt(0)));

    const key = await crypto.subtle.importKey(
      'raw', 
      encodedPassword, 
      { name: 'PBKDF2' }, 
      false, 
      ['deriveKey']
    );

    const derivedKey = await crypto.subtle.deriveKey(
      {
        name: 'PBKDF2',
        salt: enc.encode('salt'),
        iterations: 100000,
        hash: 'SHA-256'
      },
      key,
      { name: 'AES-GCM', length: 256 },
      false,
      ['decrypt']
    );

    const decryptedContent = await crypto.subtle.decrypt(
      {
        name: 'AES-GCM',
        iv: iv
      },
      derivedKey,
      encryptedContent
    );

    const dec = new TextDecoder();
    return dec.decode(decryptedContent);
  }

  async encrypt(event) {
    event.preventDefault();
    const password = this.encryptionPasswordTarget.value;
    const textToEncrypt = this.rawContentTarget.value;
    const encrypted = await this.encryptText(password, textToEncrypt);
    this.cryptedContentTarget.value = encrypted;
  }

  async decrypt(event) {
    event.preventDefault();
    const password = this.encryptionPasswordTarget.value;
    const encrypted = this.cryptedContentTarget.value;
    const decrypted = await this.decryptText(password, encrypted);
    this.rawContentTarget.value = decrypted;
  }
}
