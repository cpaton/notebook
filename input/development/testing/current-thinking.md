---
layout: page
title: Current thinking
page_display_sort_order: 1
---

* Basic attributes of a good test
   * **Fast** Quick feedback is essential to get value out of the tests
   * **Isolated/Indepdendent** The result of a test should not be dependent on any other test.  You should be able to run tests in any order and get the same result each time
   * **Repetable** Should be able to run a test many times and get the same result each time.
   * **Explain failure** If a test fails it should be easy to identify what feature is not working as expected.  Aim for a single assert per test
   * **Readable** Tests must be easy to scan to understand what they are require to run and what function they are verifying
* Test function/features and not implementation.  The test suite should support refactoring not hinder it.  Following the pattern of test class per production class tends to lead to testing implementation details resulting in the tests changing everytime the code changes.  Prefer component style tests which test a logical unit, ideally the test should be at the level of a business feature that with a small amount of time could be explained to a user of the system and they would know why the test existed and what part of visible functionality it verifies.  To keep tests fast they must only test witihn a single process but it is common for them to span all layers within that process.  For example given a user interface that has a few layers (presentation, services, domain) that talks to a back end service tests might exist for a message being received from the back end service all the way through to the view model on the screen.
* Use mocks sparingly.  Mock at process boundaries but rarely for classes within a boundary.  Using too many mocks results in brittle tests and in embedding implementation details in the tests.  If needs be create simple implementations of interfaces that can also be used in the test code.  It should be easy to setup the services used within a boundary so that they can be used in a test
* Inspired from BDD, language is important.  The tests should be written to specify what the system should do and not what it does.  This is a subtle shift but has big consequences.  This again helps to test features and not implementation and results in more readable test names

# Consequences

This style of testing has evolved over a few years and continues to evolve.  Here are some of the consequences

* Test code tends to be more complicated than the test class per production class pattern.  Often there is a class hierarchy were the base classes perform common setup and make common assertions.  On the surface this looks complicated but in general this has not been a problem.  This is in direct tension with the important goal of readability as having the code span multiple classes can make this harder, care must be taken to make the setup as terse as possible typically via the introduction of DSL for the test setup.  Worth noting that this has primarily been tried out on a large existing codebase where the infrastructure was largely baked and not changing significantly.  On a more greenfield application with signigifcant churn this could turn into a problem.
* Tests are very resilient to refactoring.  This has been the biggest plus of this style of testing, it has been possible to perform large scale refactoring of the internals of the application without modifying a single test.  This is very powerful and has encouraged continuous improvement of the design of the system.
* By testing at the feature/function level the tests stay relevant for longer and it is easier to understand which tests should change as new requirements come in.

# Sample

I have not tried tools like SpecFlow in a significant way and believe they could be useful to suppor this style of testing.  Typical pattern is to create a mini framework on top of the unit test library already in use e.g. NUnit.

Sample base class

``` c#
public abstract class Spec 
{
    [Setup]
    public virtual void Setup()
    {
        EstablishContext();
        Act();
    }

    protected virtual void EstablishContext()
    {

    }

    protected virtual void Act()
    {

    }
}
```

Sample spec/test

``` c#
[TestFixture]
public User_clicks_on_cell_in_first_row_of_grid : Spec
{
    protected override EstablishContext() 
    {
        _grid = new GridModel();
    }

    protected override Act() 
    {
        _grid.Clicked(0, 0);
    }

    [Test]
    public void Should_colour_cell_background_to_denote_selected() 
    {
        Cell(0, 0).ShouldHaveBackground(Colour.Blue);
    }

    [Test]
    public void Should_draw_solid_border_around_cell()
    {
        Cell(0, 0).ShouldHaveSolidBorder(Colour.Black);
    }

    private CellExpectation Cell(int row, int column)
    {
        return new CellExpectation(_grid, row, column);
    }
}

```

Corresponding CellExpectation helper class

``` c#
public class CellExpectation
{
    private readonly GridModel _gridModel;
    private readonly int _row;
    private readonly int _column;

    public CellExpectation(GridModel gridModel, int row, int column)
    {
        _gridModel = gridModel;
        _row = row;
        _column = column;
    }

    public void ShouldHaveBackground(Colour expected)
    {
        var actual = _gridModel.CellFormat(_row, _column).BackColour;
        Assert.That(actual. Is.EqualTo(expected), "Cell background at row {0} column {1} incorrect", _row, _column);
    }

    public void ShouldHaveSolidBorder(Colour expected)
    {
        var actualFormat = _gridModel.CellFormat(_row, _column);
        Assert.That(actualFormat.BorderThickness. Is.EqualTo(Border.Normal), "Cell border at row {0} column {1} incorrect", _row, _column);
        Assert.That(actualFormat.BorderColour. Is.EqualTo(expected), "Cell background at row {0} column {1} incorrect", _row, _column);
    }
}
```