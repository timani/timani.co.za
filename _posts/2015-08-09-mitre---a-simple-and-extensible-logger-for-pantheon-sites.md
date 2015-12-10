---
layout: post
title: "Mitre - A simple and extensible logger for Pantheon sites"
---
<div class="entry-content" itemprop="articleBody">
		<p>We most frequently use Curl in the form of `libcurl`, a C library providing function transferring data between servers using many of the popular protocols like HTTP, FTP, SCP, and so on.  This library is the foundation things like all the <code>curl_*()</code> functions in PHP, which are useful for writing code that interacts with various web services.</p>

    <!--more-->
<p>But there is also the Curl command line program, built atop the same library. I find the program useful for debugging and testing certain aspects of web applications, so I wanted to share a list of the things I like to do with Curl, which I hope you will find useful as well.</p>
<h2>Headers</h2>
<p>To see the headers from a site:</p>
<pre lang="bash">$ curl --head <a href="http://example.com/" target="_blank">http://example.com</a></pre>
<p>We can use this to make sure any custom headers are being sent properly, and to see things like what cache information the server is sending to browsers.  It will also show information like the PHP session ID.  Or more importantly sometimes is what the command does not show, if we have an error in our code that prevents necessary headers from being sent.</p>
<h2>Cookies</h2>
<p>The command above will show cookie info, but if that’s all we’re interested in then we use this:</p>
<pre lang="bash">$ curl --cookie-jar cookies.txt <a href="http://example.com/" target="_blank">http://example.com/</a></pre>
<p>We can then inspect the cookies to see if the values are set to what we expect.  Or to try out different things we can change the values and then run:</p>
<pre lang="bash">$ curl --cookie cookies.txt <a href="http://example.com/" target="_blank">http://example.com/</a></pre>
<p>to simulate a request using our new cookie values. By using the option `–junk-session-cookies` in conjunction with the above, we can send all of our modified cookies but without any session information. This has the effect of behaving as if we had closed our browser.</p>
<h2>Forms</h2>
<p>When we want to write a script that deals with submitting a &lt;form&gt;, we can use the <code>--data</code> option to pass in values to the form fields.  For example, to test a script where users can post comments to a site:</p>
<pre lang="bash">$ curl --data username='Lobby C Jones' --data email='<a href="https://host.cybersprocket.com:2096/3rdparty/squirrelmail/src/compose.php?send_to=Lobby%40cybersprocket.com" target="_blank">Lobby@cybersprocket.com</a>' --data message='Nom nom nom' <a href="http://localhost/eric/test.php" target="_blank">http://localhost/eric/test.php</a></pre>
<p>If the message we wanted to send was really long, we could put it in a text file and then change that particular option to:</p>
<pre lang="bash">--data-urlencode <a href="https://host.cybersprocket.com:2096/3rdparty/squirrelmail/src/compose.php?send_to=message%40input.txt" target="_blank">message@input.txt</a></pre>
<p>That is, we can write:</p>
<pre lang="bash">--data-urlencode name@file</pre>
<p>to mean the same thing as:</p>
<pre lang="bash">--data name=&lt;contents of file&gt;</pre>
<p>This is *not* a file upload; it is simply a way to read contents from a file and use them as a form parameter value.  To perform an actual file upload we can use the `–form` option.  Let’s say we want to simulate uploading a CSV file to a web application:</p>
<pre lang="bash"> $ curl --form doc=@our-data.csv <a href="http://probably.dtuser.com/" target="_blank">http://probably.dtuser.com/</a></pre>
<p>This would upload <code>our-data.csv</code> as the <code>doc</code> form field.  If needed, we can specify the content type:</p>
<pre lang="bash">$ curl --form "photo=@lobby.png;type=image/png" <a href="http://lonelysingles.com/photos/shellfish/upload.php" target="_blank">http://lonelysingles.com/photos/shellfish/upload.php</a></pre>
<p>We can use <code>--get</code> to send our data in the form of <code>GET</code> instead of a <code>POST</code>, although this does not work with <code>--form</code> since it always uses the content type <code>multipart/form-data</code>.  But it will modify any <code>--data</code> that we send to be appended to the URL.</p>
<h2>Timeouts and Retries</h2>
<p>When using Curl in scripts we want to avoid situations where the whole operation might hang, either because the server hangs, or because we are using the script to download something when the network connection is very slow, or because of a solar flare.  We can use three options to avoid these problems.</p>
<ol>
<li><code>--connect-timeout &lt;N&gt;</code> will wait N seconds for the connection to succeed before bailing.  This only affects the connection.  Once we successfully initiate communication with the server, there is no time limit.  To control that we use…</li>
<li><code>--max-time &lt;N&gt;</code> which only allows N seconds for the entire operation.</li>
<li><code>--no-solar-flare</code> avoids all solar flares.</li>
</ol>
<p>If we are scripting an operation that could fail then we can tell Curl to retry a number of times by using <code>--retry &lt;N&gt;</code>.  If the request fails, Curl will wait one second and then try again.  That delay then doubles after every successive failure, maxing out at ten minutes.</p>
<h2>PUT Requests</h2>
<p>We usually don’t deal with web applications that respond to PUT requests(although I think it’s a useful practice).  In the cases where we are, we can use Curl to easily test out PUT requests by sending the contents of a file like so:</p>
<pre lang="bash">$ curl -T file.png <a href="http://example.com/put/script.php" target="_blank">http://example.com/put/script.php</a></pre>
<p>Or if we wanted to PUT multiple files at once:</p>
<pre lang="bash">$ curl -T "image[1-100].png" <a href="http://example.com/put/script.php" target="_blank">http://example.com/put/script.php</a></pre>
<p>This has the effect of PUT-ing the files <code>image1.png</code>, <code>image2.png</code>, and so on up to <code>image100.png</code>.</p>
<h2>Other Requests</h2>
<p>Besides <code>PUT</code>, there is also <code>DELETE</code>, which again is not commonly encountered. If needed, we can make such requests with Curl like so:</p>
<pre lang="bash">$ curl --request DELETE <a href="http://localhost/resource/to/delete/" target="_blank">http://localhost/resource/to/delete/</a></pre>
<p>If we are using Curl to interact with FTP then the request command can be any valid FTP command. And that’s it for my brain-dump about Curl usage.  Everything I’ve shown above can be accomplished by browsers, either out-of-the-box or via various add-ons.  But where I like to use Curl is in scripts; in contrast to browsers, Curl makes it easy to create a repeatable series of requests to send to a site, and then I can do simple tests on those results to determine whether or not something worked as expected.  If you have any questions about Curl, or anything you like to use it for that hasn’t been covered here, then please share.</p>
<div class="sharedaddy sd-block sd-like jetpack-likes-widget-wrapper jetpack-likes-widget-loaded" id="like-post-wrapper-45816809-2665-55c69dfe646d6" data-src="//widgets.wp.com/likes/#blog_id=45816809&amp;post_id=2665&amp;origin=www.storelocatorplus.com&amp;obj_id=45816809-2665-55c69dfe646d6" data-name="like-post-frame-45816809-2665-55c69dfe646d6"><h3 class="sd-title">Like this:</h3></div>		</div>
