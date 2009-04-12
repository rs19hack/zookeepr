<%
attribs = "?page=" + str(c.registration_pages.current.next)
for item, value in c.registration_request.iteritems():
    if type(value) == list:
        for option in value:
            attribs += "&" + item + "=" + option
    elif item != 'page':
        attribs += "&" + item + "=" + value
%>

<script type="text/javascript">
function display_toggle(box)
{
    div = document.getElementById(box);
    if (div.style['display'] == 'none')
    {
        div.style['display'] = 'block';
    }
    else
    {
        div.style['display'] = 'none';
    }
    return false;
}
</script>

    <h2>Registration List</h2>
    <form method="GET" action="/registration">
    <p style="float: right;">Products (inclusive):<br><select name="product" multiple="multiple" size="14">
<%
selected = ''
if "all" in c.registration_request['product']:
   c.registration_request['product'] = []
   selected = ' selected="selected"'
%>
          <option value="all"${ selected }>--Any--</option>
% for category in c.product_categories:
          <optgroup label="${ category.name }">
%   for product in category.products:
%       if product.id in [int(id) for id in c.registration_request['product']]:
            <option value="${ product.id }" selected="selected">${ product.description }</option>
%       else:
            <option value="${ product.id }">${ product.description }</option>
%       endif
%   endfor
          </optgroup></p>
% endfor
        </select>
    <p style="vertical-align: top;">Role:<br >
    <select name="role" multiple="multiple" size="9">
<%
selected = ''
if "all" in c.registration_request['role']:
   selected = ' selected="selected"'
%>
        <option value="all"${ selected }>--Any--</option>
<%
selected = ''
if "speaker" in c.registration_request['role']:
   selected = ' selected="selected"'
%>
        <option value="speaker"${ selected }>Speaker</option>
<%
selected = ''
if "miniconf" in c.registration_request['role']:
   selected = ' selected="selected"'
%>
        <option value="miniconf"${ selected }>Miniconf Organiser</option>
<%
selected = ''
if "volunteer" in c.registration_request['role']:
   selected = ' selected="selected"'
%>
        <option value="volunteer"${ selected }>Volunteer</option>
% for role in c.roles:
<%
   selected = ''
   if role.name in c.registration_request['role']:
       selected = ' selected="selected"'
%>
        <option value="${ role.name }"${ selected }>${ role.name }</option>
% endfor
    </select>

    <br />Status: <select name="status">
        <option value="all">--Any--</option>
<%
selected = ''
if "status" in c.registration_request and c.registration_request['status'] == 'unpaid':
   selected = ' selected="selected"'
%>
        <option value="unpaid"${ selected }>Unpaid</option>
<%
selected = ''
if "status" in c.registration_request and c.registration_request['status'] == 'paid':
   selected = ' selected="selected"'
%>
        <option value="paid"${ selected }>Paid</option>
    </select>
    <br><input name="per_page" value="${ c.per_page }" size="3" /> Per Page
<%
selected = ''
if "diet" in c.registration_request and c.registration_request['diet'] == 'true':
   selected = ' checked="checked"'
%>
    <br><label for="diet"><input type="checkbox" name="diet" id="diet" value="true"${ selected } /> Has Diet</label>
<%
selected = ''
if "special_needs" in c.registration_request and c.registration_request['special_needs'] == 'true':
   selected = ' checked="checked"'
%>
    <label for="special_needs"><input type="checkbox" name="special_needs" id="special_needs" value="true"${ selected } /> Has Special Needs</label>
<%
selected = '' 
if "notes" in c.registration_request and c.registration_request['notes'] == 'true':
    selected = ' checked="checked"'
%>
    <br><label for="notes"><input type="checkbox" name="notes" id="notes" value="true"${ selected } /> Has Notes</label>
<%
selected = ''
if "under18" in c.registration_request and c.registration_request['under18'] == 'true':
   selected = ' checked="checked"'
%>
    <label for="under18"><input type="checkbox" name="under18" id="under18" value="true"${ selected } /> Is Under 18</label>
<%
selected = ''
if "voucher" in c.registration_request and c.registration_request['voucher'] == 'true':
   selected = ' checked="checked"'
%>
    <br><label for="voucher"><input type="checkbox" name="voucher" id="voucher" value="true"${ selected } /> Used Voucher</label>
<%
selected = ''
if "manual_invoice" in c.registration_request and c.registration_request['manual_invoice'] == 'true':
   selected = ' checked="checked"'
%>
    <label for="manual_invoice"><input type="checkbox" name="manual_invoice" id="manual_invoice" value="true"${ selected } /> Has Manual Invoice</label>
    <br>
    <input type="submit" value="Update" />
    </p>
    </form>
    
    <p style="float: right;">${ h.link_to('Export as CSV', url=attribs + "&export=true") }</p>
    
    <table style="clear: both;"> 
      <thead><tr>
        <th>Rego</th>
        <th>Name</th>
        <th>Email</th>
        <th>Role(s)</th>
        <th>Invoices</th>
        <th>Notes</th>
      </tr></thead>
<% count = 0 %>
% for registration in c.registration_collection:
    <% count += 1 %>
      <tr>
        <td>${ h.link_to('id: ' + str(registration.id), url=h.url_for(action='view', id=registration.id)) }</td>
        <td>${ h.link_to(h.util.html_escape(registration.person.firstname + ' ' + registration.person.lastname), h.url_for(controller='person', action='view', id=registration.person.id)) }</td>
        <td>${ registration.person.email_address | h }</td>
        <td>
<%
   role = []
   if registration.person.is_speaker():
       role.append('Speaker')
   if registration.person.is_miniconf_org():
       role.append('miniconf Organiser')
   if registration.person.is_volunteer() == None:
       role.append('Volunteer pending')
   elif registration.person.is_volunteer() == True:
       role.append('Volunteer')
   for auth_role in registration.person.roles:
       role.append(auth_role.name)
%>
        ${ '<i>' + '</i>, <i>'.join(role) + '</i>' }
        </td>
        <td>
%   for rinvoice in registration.person.invoices:
        ${ h.link_to(rinvoice.id, h.url_for(controller='invoice', action='view', id=rinvoice.id)) } - <small>${ rinvoice.status() }</small>
%       if rinvoice.manual is True:
            <i>(manual)</i>
%       endif
        <small><a href="#" onclick="return display_toggle('products_${ rinvoice.id }')">+</a></small>
<%
       display = "display: none;"
       if rinvoice.is_void() is not True: display=""
%>
        <div id="products_${ rinvoice.id }" style="${ display } background: #ddd;">
%       for rproduct in rinvoice.items:
          ${ rproduct.qty }<small> x ${ rproduct.description }</small><br>
%       endfor
        </div>
%   endfor
%   if registration.voucher:
        <i>Voucher Used:</i>
%       for vproduct in registration.voucher.products:
          ${ vproduct.qty }<small> x ${ vproduct.product.description } @ ${ h.number_to_percentage(vproduct.percentage) } Discount</small><br>
%       endfor
%   endif
        </td>
        <td>
%   if not registration.over18:
        <b>Under 18</b> ${ h.yesno(not registration.over18) }<br><br>
%   endif
            ${ 'FIXME' or '<br><br>'.join(["<b>Note by <i>" + n.by.firstname + " " + n.by.lastname + "</i> at <i>" + n.last_modification_timestamp.strftime("%Y-%m-%d&nbsp;%H:%M") + "</i>:</b><br>" + h.line_break(n.note) for n in registration.notes]) + '<br><br>' }
%   if registration.diet:
            ${ '<b>Diet:</b> %s<br><br>' % (registration.diet) }
%   endif
%   if registration.special:
            ${ '<b>Special Needs:</b> %s<br><br>' % (registration.special) }
%   endif
        ${ h.link_to("Add New Note", h.url_for(controller='rego_note', action='new', rego_id=registration.id)) }
        </td>
      </tr>
% endfor
    </table>
<p>
<%
if c.registration_pages.current.next:
    m.write(h.link_to('<span style="float: right;">Next page</span>', url=attribs))
if c.registration_pages.current.previous:
    m.write(h.link_to('Previous page', url=h.url(page=c.registration_pages.current.previous)) + '  ')
%>
</p>
<%
start = c.registration_pages.current_page * c.registration_pages.items_per_page
inc = 1
if count == 0:
    inc = 0
%>
<p style="float: right;">Displaying ${ start + inc }-${ start + count } of ${ c.registration_pages.item_count }.</p>
