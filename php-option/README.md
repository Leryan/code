# php-option

Never check for null anymore - PHP

## Usage

### Default value

No check required, you provide a default value in case the returned `Option` is `None`:

```php
<?php

require_once 'null.php';

class MyObject {
    public function work() {
      echo 'I do something';
    }
}

$oDefaultObject = new MyObject();
$oOption = someObscureGetter(); // Returns an Option() that is either Some(MyObject) or None()

$oOption->get($oDefaultObject)->work(); // You can blindly call the work() method because you're sure you'll get a MyObject instance
```

### Option checked

```php
<?php

require_once 'null.php';

class MyObject {
    public function work() {
      echo 'I do something';
    }
}

$oOption = someObscureGetter();

if (Option::some($oOption)) {
    $oOption->work();
} elseif (Option::none($oOption)) {
    throw new Exception('It\'s empty here');
}
```

## Making an Option

```php
<?php

require_once 'null.php';

class TemporalBullshit {

    private $iTime;

    public function __construct($iTime) {
        $this->iTime = $iTime;
    }
    
    public function getTime() {
        return $this->iTime;
    }
}

class Remote {
    public static function getSomething() {
        $iTime = time();

        if ($iTime % 2 == 0) {
            return Option::of(null);
        }
        return Option::of(new TemporalBullshit($iTime));
    }
}

class MyObject {

    public function getSomething() {
        $mValue = Remote::getSomething();
        return Option::of($mValue);
    }

}

$oInst = new MyObject();

$oOption = $oInst->getSomething();

// do something based on previous examples with you Option
```

## Inspired by

 * Clever Cloud blog: https://www.clever-cloud.com/blog/engineering/2016/07/21/null-is-not-the-issue/
 * DASCHL blog: http://nitschinger.at/A-Journey-on-Avoiding-Nulls-in-PHP/

## Better implementation(s) you and me should use instead

 * https://github.com/schmittjoh/php-option
