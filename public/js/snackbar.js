var snackbar = document.querySelector('#snackbar');
var flashes = document.querySelector('#details').innerHTML.split("¤").filter(Boolean);
console.log(flashes);
console.log(flashes.length);
for (var i = 0; i < flashes.length; i++){
  snackbar.MaterialSnackbar.showSnackbar({message: flashes[i]});
}
