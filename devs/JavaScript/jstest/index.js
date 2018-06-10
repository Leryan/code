var $ = require('jquery');
require('materialize');

function TestAppThis(button, texts, timeout) {
    this._btn = button;
    this._texts = texts;
    this._timeout = timeout;
    this._counter = 0;

    this.loop = function() {
        txt = this._texts.slice(0, this._counter + 1).join("");
        this._btn.html(txt);
        this._counter = (this._counter + 1) % this._texts.length;
        setTimeout(this.loop.bind(this), this._timeout);
    };
}

function TestAppSelf(button, texts, timeout) {
    var self = this;

    self._btn = button;
    self._texts = texts;
    self._timeout = timeout;
    self._counter = 0;
    self._clicked = false;

    self.run = function() {
        if (self._clicked === false) {
            self.loop();
        }
        self._clicked = true;
    }

    self.loop = function() {
        txt = self._texts.slice(0, self._counter + 1).join("");
        self._btn.html(txt);
        self._counter = (self._counter + 1) % self._texts.length;
        setTimeout(self.loop, self._timeout);
    };
}

function main() {
    var btnthis = $("#coolbuttonthis");
    var btnself = $("#coolbuttonself");
    testappthis = new TestAppThis(btnthis, ["", "Hello", " This", " World", "!"], 500);
    testappself = new TestAppSelf(btnself, ["", "Hello", " Self", " World", "!"], 500);

    btnthis.click(function() { testappthis.loop(); });
    btnself.click(function() { testappself.run(); });
}

$(document).ready(main);
