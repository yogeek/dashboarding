# Smashing Dashboard

https://smashing.github.io/

A Sinatra based framework that lets you build excellent dashboards.
Demo : http://dashingdemo.herokuapp.com/sample

## Learning environment

A docker-based environment is provided to quickly begin to learn smashing development.

Launch the environment with :

```bash
./dev.sh
```

You are now in a container in which you can initiliaze a new project :

```bash
smashing new my_sample_dashboard
cd my_sample_dashboard
```

A bunch of files have been created in "my_sample_dashboard" local directory.
You can now use `bundle`, the ruby package manager, to install all necessary gems for your brand new project.

```bash
bundle install
```

Now that everything is installed, you can start the server :

```bash
smashing start
```

Go to http://localhost:3030 : a cool sample dashboard is displayed !
You can drag all the widgets around as you like.

To add date into a widget, you have 2 solutions :
- you can also push some data into the widgets by calling the widget API :

```bash
curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "Hey, Look what I can do !" }' http://localhost:3030/widgets/welcome
```

- you can add a new `job` in `jobs` folder that will regularly send data to the widget id.

## Create your first dashboard

You can create a dashboard by using :

```bash
smashing generate dashboard devops
```

It will create a `devops.rb` file into the `dashboards` folder, with 1 widget to begin with.
In this file :

- `data-view` is the kind of the widget (see `widgets` folder for a list of installed widgets)
- `data-id`  is the ID of the widget (used by the server to send data to this widget)

The dasboard is now available at : http://localhost:3030/devops
There is no data in it yet but you can push some with by curling the widget endpoint :

```bash
curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "Bienvenue à tous les DevOps !" }' http://localhost:3030/widgets/my_widget
```

## Create your first widget

Now suppose you want to change the default widget above by a home-made "Alert" widget which will change color according to a threshold.
Replace `data-view="Text"` by `data-view="Alert"` in the `dashboards/devops.rb` dashboard file and set the `data-id` to `response_time`.
Refresh the page : nothing ! Right, `Alert` widget does not exist...

So create a new widget called `Alert`:

```bash
smashing generate widget alert
```

Three files have been created in the `widgets/alert` folder :

- `alert.coffee` : to handle the widget logic 
- `alert.html` : to handle the widget layout
- `alert.scss` : to hadle the widget style

Go in `widgets/alert/alert.scss` and add a background colour to the widget:

```css
.widget-alert {
  background: #00ff99;
}
```

Refresh the [dashboard](http://localhost:3030/devops) page : your new widget is displayed. (and can be moved around)

```bash
curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "value": "100" }' http://localhost:3030/widgets/response_time
```

But how...?
In the `widgets/alert/alert.html` file, you can see that the `data-bind` is called `value`. This is where the magic happens !
It is using a "Data Binding" principle (like in Angular or other JS frameworks) which means that every time the widget receive a JSON data from the server with the key `value` in it, it will update the html div with the value of this key.

Let's make the font bigger in `widgets/alert/alert.scss` :

```css
.widget-alert {
  background: #00ff99;
  font-size: 65px;
  font-weight: bold;
}
```

and add a header to `alert.html` :

```html
<h1>Response Time</h1>
<div data-bind="value"></div>
```

Now we want to display a red color if the value is above a certain threshold.
Add `data-addclass-danger="isTooHigh"` to line 4 of `devops.erb` :

```html
<div data-id="response_time" data-view="Alert" data-addclass-danger="isTooHigh"></div>
```

This will add a class (CSS one) called "danger" if `isTooHigh` is true.

In `alert.coffee`, add this to the bottom to set the `isTooHigh` condition :

```coffee
@accessor 'isTooHigh', ->
    @get('value') > 300
```

In `alert.scss`, add the `danger` class :

```css
.danger {
  background: red;
}
```

Try cURLing the API again but with different values. If the value is higher than 300, then the widget should be red !

```bash
for i in 100 500 200 400 300; do 
  curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "value": "'$i'" }' http://localhost:3030/widgets/response_time
  sleep 2
done
```

## Create your first job

Pushing data to the widget API is nice but jobs are relly a convenient way to make the server updating the widgets according to whatever logic we want.

Create a new job:

```bash
smashing generate job devops
```

A now job has been added : `jobs/devops.rb`.
Change this file to this :

```ruby
# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1s', :first_in => 0 do |job|
  send_event('response_time', { value: rand(400) })
end
```

Every second, this job will send random values between 0 and 400 to the `response_time` widget.

Restart the server, and watch the widget update!

```bash
smashing start
```

Let's animate our widget a bit ! Add this to the bottom of `alert.coffee`:

```coffee
@accessor 'value', Dashing.AnimatedValue
```

It is then really easy to add some widgets to a dashboards. Try duplicate the `<li>` element multiple times in the `devops.erb` dashboard
and look at the result.

Now you can build your own dahsboards !

## Additional Widgets

You can fin all kind of cool widgets here : https://github.com/Smashing/smashing/wiki/Additional-Widgets
A widget can be installed with the GIST ID of the widget found in the previous list. 

Example : Add the Chuck Norris Fact Generator widget

- Install the Chuck Norris Fact Generator Job

```bash
smashing install f8c35551138babcc3e9e
```

- Add the widget to the `devops.erb` dashboard :

```html
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="chuck" data-view="Text" data-title="Team Facts" data-moreinfo="Team Member Facts."></div>
</li>
```

Restart the server and enjoy ! :-)

## We need to go deeper...

Duplicate the widget code from ops.erb so that you have 2 of the same widget on the dashboard.

```html
<div class="gridster">
  <ul>
    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time" data-view="Alert" data-addclass-danger="isTooHigh"></div>
    </li>

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time" data-view="Alert" data-addclass-danger="isTooHigh"></div>
    </li>
  </ul>
</div>
```

Change the response_time to response_time_1 and response_time_2:

```html
<div class="gridster">
  <ul>
    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time_1" data-view="Alert" data-addclass-danger="isTooHigh"></div>
    </li>

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time_2" data-view="Alert" data-addclass-danger="isTooHigh"></div>
    </li>
  </ul>
</div>
```

In `jobs/devops.rb`, change it to send data to the 2 separate widgets:

```ruby
SCHEDULER.every '1s', :first_in => 0 do |job|
  send_event('response_time_1', { value: rand(400) })
  send_event('response_time_2', { value: rand(400) })
end
```

Remember to restart the server when you change a job!

Let's make the title of the widget configurable inside `alert.html`

```html
<h1 data-bind="title"></h1>
<div data-bind="value"></div>
```

Now in our `dashboards/ops.erb`, we can add the value that the title should have:

```html
<div class="gridster">
  <ul>
    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time_1" data-view="Alert" data-addclass-danger="isTooHigh" data-title="Response Time App1"></div>
    </li>

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time_2" data-view="Alert" data-addclass-danger="isTooHigh" data-title="Response Time App2"></div>
    </li>
  </ul>
</div>
```

Let's make the threshold dynamic instead of a hardcoded 300. In `alert.coffee`, modify the `isTooHigh` accessor:

```coffee
@accessor 'isTooHigh', ->
    @get('value') > @get('threshold')
```

We can then specify the threshold on each widget instance in `devops.erb` :

```html
<div class="gridster">
  <ul>
    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time_1" data-view="Alert" data-addclass-danger="isTooHigh" data-title="Response Time App1" data-threshold=200></div>
    </li>

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="response_time_2" data-view="Alert" data-addclass-danger="isTooHigh" data-title="Response Time App2" data-threshold=300></div>
    </li>
  </ul>
</div>
```

## Bonus Tips

You can set the default dashboard by adding the `default_dashboard` line to the `config.ru` file :

```ruby
configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'devops' #<==== set default dashboard like this
```
