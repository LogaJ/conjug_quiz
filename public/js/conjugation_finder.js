function checkConjugation() {
  var verb = $('verb_id').value
    var person = $('person').value
    var singular_plural = $('singular_plural').value

    var url     = '/ajax/conjugation';
  var options = {
    method : 'post',
    parameters : {
      verb    : verb,
      person  : person,
      number  : singular_plural
    },
    onComplete : getResponse
  };
  new Ajax.Request(url, options);
}

function getResponse(oReq) {
  $('conjug_name').value = oReq.responseText;
}
