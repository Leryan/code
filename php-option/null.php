<?php

class OptionException extends Exception {
}

class NotAnOptionException extends OptionException {
}

class NoneOptionException extends OptionException {
}

class SomeOptionException extends OptionException {
}

class Some extends Option {

    private $ref;

    public function __construct(&$ref) {
        if ($ref === null) {
            throw new SomeOptionException('Illegal value: cannot carry null');
        }

        $this->ref = $ref;
    }

    public function get($default = null) {
        return $this->ref;
    }

}

class None extends Option {

    public function get($default = null) {
        if ($default === null) {
            throw new NoneOptionException('Illegal value: default cannot be null for None');
        }

        return $default;
    }

}

abstract class Option {

    public static function of($value) {
        if ($value === null) {
            return new None();
        }

        return new Some($value);
    }

    public static function some(&$ref) {
        if (!self::is($ref)) {
            throw new NotAnOptionException();
        }

        return $ref instanceof Some;
    }

    public static function none(&$ref) {
        return !self::some($ref);
    }

    public static function is(&$ref) {
        return $ref instanceof Option;
    }

    public abstract function get($default = null);

}

function options() {
    $safe = Array(
        Option::of('Value'),
        'you don\'t saayyyyy',
        Option::of(null),
        null
    );

    // "if" version
    foreach($safe as $val) {
        if (Option::is($val)) {
            if (Option::some($val)) {
                echo "-> something: " . $val->get() . "\n";
            } elseif (Option::none($val)) {
                echo "-> nothing\n";
            }
        } else {
            echo " ! not an option: " . $val . "\n";
        }
    }

    // "exception" version
    foreach ($safe as $val) {
        try {
            if (Option::some($val)) {
                echo "-> something: " . $val->get() . "\n";
            } else {
                echo "-> nothing\n";
            }
        } catch (NotAnOptionException $ex) {
            echo " ! not an option: " . $val . "\n";
        }
    }

    // cannot give null to Some
    try {
        $nullVal = null;
        $notSoSome = new Some($nullVal);
    } catch (SomeOptionException $ex) {
        echo '!! ' . $ex->getMessage() . "\n";
    }
}

options();
