package xmlpl.xml 0.0.1;

prefix getPrefix(qname name) {
  __native__
  return XPL_name ? XPL_name->getPrefix() : 0;
  __native__
}

string getLocalName(qname name) {
  __native__
  return XPL_name ? XPL_name->getName() : "";
  __native__
}

string getPrefixName(qname name) {
  __native__
  return XPL_name ? XPL_name->getPrefixName() : "";
  __native__
}

string getName(prefix pre) {
  __native__
  return XPL_pre ? XPL_pre->getName() : "";
  __native__
}

string getURI(qname name) {
  __native__
  return XPL_name ? XPL_name->getURI() : "";
  __native__
}

string getURI(prefix pre) {
  __native__
  return XPL_pre ? XPL_pre->getURI() : "";
  __native__
}

qname name(element e) {
  __native__
 return XPL_e.get() ? XPL_e->getName() : QNameNull();
  __native__
}

qname name(attribute a) {
  __native__
 return XPL_a.get() ? XPL_a->getName() : QNameNull();
  __native__
}

string value(attribute a) {
  __native__
 return XPL_a.get() ? XPL_a->getText() : StringNull();
  __native__
}

string target(pi p) {
  __native__
 return XPL_p.get() ? XPL_p->getTarget() : StringNull();
  __native__
}

string data(pi p) {
  __native__
  return XPL_p.get() ? XPL_p->getText() : StringNull();
  __native__
}


void append(element e, node n) {
  if (e == null) throw "append called with null element";
  if (n == null) return;

  __native__
  Node *child = XPL_e->getFirstChild();
  Node *clone = XPL_n->clone();
  if (clone->getType() == TypeID::ELEMENT_TYPE) clone->setParent(XPL_e.get());
  clone->incRef();

  if (!child) XPL_e->setFirstChild(clone);

  else {
    while (child->getNext())
      child = child->getNext();

    child->setNext(clone);
  }
  __native__
}

void append(element e, attribute a) {
  __native__
  XPL_e->setAttribute((Attribute *)XPL_a->clone());
  __native__
}

attribute Attribute(qname name, string value) {
  __native__
  return createAttribute(XPL_name, XPL_value);
  __native__
}

element Document(node x) {
  __native__
  if (XPL_x.get() && XPL_x->getType() == TypeID::DOCUMENT_TYPE)
    return (Document *)XPL_x.get();
  else return 0;
  __native__
}

element Element(node x) {
  __native__
  if (XPL_x.get() && XPL_x->getType() == TypeID::ELEMENT_TYPE)
    return (Element *)XPL_x.get();
  else return 0;
  __native__
}

text Text(node x) {
  __native__
  if (XPL_x.get() && XPL_x->getType() == TypeID::TEXT_TYPE)
    return (Text *)XPL_x.get();
  else return 0;
  __native__
}

comment Comment(node x) {
  __native__
  if (XPL_x.get() && XPL_x->getType() == TypeID::COMMENT_TYPE)
    return (Comment *)XPL_x.get();
  else return 0;
  __native__
}

pi PI(node x) {
  __native__
  if (XPL_x.get() && XPL_x->getType() == TypeID::PI_TYPE)
    return (PI *)XPL_x.get();
  else return 0;
  __native__
}

attribute Attribute(node x) {
  __native__
  if (XPL_x.get() && XPL_x->getType() == TypeID::ATTRIBUTE_TYPE)
    return (Attribute *)XPL_x.get();
  else return 0;
  __native__
}

element[] decendant_or_self(element[] x, string n) {
  foreach (x) {
    if (name(.) == n) .;
    foreach (./*) decendant_or_self(., n);
  }
}

element[] decendant_or_self(element x, qname n);
element[] decendant_or_self(element[] x, qname n) {
  foreach (x) {
    if (name(.) == n) .;
    foreach (./*) decendant_or_self(., n);
  }
}

element[] decendant_or_self(element x, qname n) {
  decendant_or_self((element[])x, n);
}

element[] ancestor_or_self(element x) {
  x;
  if (x) ancestor_or_self(x/..);
}

node[] copy(node[] x);

attribute copy(attribute a) {
  if (a) return Attribute(name(a), value(a));
  return null;
}

element copy(element e) {
  element c;
  if (e) c = 
    <(name(e))>
      foreach (e/@*) copy(.);
      copy(e/node());
    </>;

  return c;
}

text copy(text t) {
  if (t) return Text(t);
  return null;
}

comment copy(comment c) {
  if (c) return <!--(c)-->;
  return null;
}

pi copy(pi p) {
  if (p) return <?(target(p))(data(p))?>;
  return null;
}

node copy(node x) {
  if (Element(x)) return copy(Element(x));
  if (Text(x)) return copy(Text(x));
  if (Comment(x)) return copy(Comment(x));
  if (PI(x)) return copy(PI(x));
}

node[] copy(node[] x) {
  foreach (x) copy(.);
}

element remove(element x) {
  element p = x/..;
  if (!p) return x;

  __native__
  Element *x = XPL_x.get();
  Node *p = XPL_p.get();

  if (p) {
    if (p->getFirstChild() == x) p->setFirstChild(x->getNext());

    else for (p = p->getFirstChild(); p && p->getNext(); p = p->getNext())
      if (p->getNext() == x) {
        p->setNext(x->getNext());
 	break;
      }
  }

  x->setNext(0);
  x->setParent(0);
  __native__

  return x;
}

element remove(element[] x) {
  foreach (x) remove(.);
  return x;
}

string getText(element e) {
  string s;
  foreach (e/text()) s += .;
  return s;
}
