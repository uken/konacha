mocha.ui('bdd');

var expect = chai.expect,
    should = chai.should(),
    assert = chai.assert;

window.onload = function () {
  mocha.run();
};
