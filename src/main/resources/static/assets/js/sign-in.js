const autoblock = document.querySelector('autologinbox');
const checkbox = document.getElementById('auto-login')
checkbox.addEventListener('click', e.tartget  )

autoblock.addEventListener('click', function(event) {
  if (event.target === autoblock) {
      event.preventDefault();
  }
