# Interface Segregation Principle

**No client should be forced to depend on methods it does not use**

**“YOU SHOULD ONLY DEFINE METHODS THAT ARE GOING TO BE USED”.**

This principle basically says that it's better to create more specific interfaces rather than having a single generic interface.

Wrong:
```js
interface IMultiFunction {
    public void print();
    public void getPrintSpoolDetails();
    public void scan();
    public void scanPhoto();
    public void fax();
    public void internetFax();
}

class CanonPrinter implements IMultiFunction {

    @Override
    public void print() {}

    @Override
    public void getPrintSpoolDetails() {}

    /* This machine can't scan */
    @Override
    public void scan() {}

    /* This machine can't scan photo */
    @Override
    public void scanPhoto() {}

    /* This machine can't fax */
    @Override
    public void fax() {}

     /* This machine can't fax on internet */
    @Override
    public void internetFax() {}

}
```

A class should not be required to implement interfaces that it will not use.

Correct:
```js
interface Movie {
	public function play();
}
interface AudioControl {
	public function increaseVolume();
}

class TheLionKing implements Movie, AudioControl {
	public function play() {}
	public function increaseVolume() {}
}

class ModernTimes implements Movie {
	public function play() {}
}
```